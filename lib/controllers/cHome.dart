import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:renesis_tech/config/baseurl.dart';
import 'package:intl/intl.dart';
import 'package:renesis_tech/models/quote.dart';
import 'package:renesis_tech/models/quotesDBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CHome extends ChangeNotifier {
  int selectedIndex = 0;
  List<Quotes> listOfQuotes = new List<Quotes>();
  var now = new DateTime.now();
  bool loadingQuotes = true;
  GlobalKey<ScaffoldState> homeScaffold = GlobalKey<ScaffoldState>();

  //Getting the current time to check the possibility of new fetch call.
  var timeFormate;
  String currentTime;
  QuotesDBHelper quotesDBHelper =
      new QuotesDBHelper(); //init the db helper to handle local db operations.
  CHome() {
    timeFormate = DateFormat("HH:mm:ss");
    currentTime = timeFormate.format(now);
    getRandomQuotes();
  }

  Future<void> getRandomQuotes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    loadingQuotes = true;
    notifyListeners();

    var lastSync = pref.getString("lastSync") ?? "00:00:00";
    var lastSyncFormated = timeFormate.parse(lastSync);
    var currentTimeFormated = timeFormate.parse(currentTime);
    //checking difference between current time and last sync
    Duration timeDifferenct = currentTimeFormated.difference(lastSyncFormated);
    Duration maxDuration = new Duration(hours: 23, minutes: 59, seconds: 59);
    if (timeDifferenct > maxDuration) {
      await getDataFormApi(pref);

    } else {
      //fetch quotes from local db
      List<Quotes> savedQuots = await quotesDBHelper.getallQuotes();
      //if no quote available then we fetch from api and save in local db
      if (savedQuots.length == 0) {
        print("no data");
        await getDataFormApi(pref);
      } else {
        //if not quotes found in local db then assign to quotes list
        listOfQuotes = savedQuots;
        print("quotes loaded form db");
      }
    }
    //replacing loader with data
    loadingQuotes = false;
    notifyListeners();
  }

  Future<void> getDataFormApi(SharedPreferences pref) async {
    int quotesPageNo = pref.getInt("quotesPageNo") ?? 1;
    final quotesResponse =
        await http.get('${Baseurl.api}v2/quotes?page=$quotesPageNo&limit=10');
    if (quotesResponse.statusCode == 200) {
      QuotesResp quotesResp =
          QuotesResp.fromJson(json.decode(quotesResponse.body));
      listOfQuotes = quotesResp.quotes;
      // notifyListeners();
      //saving to local db.
      if (listOfQuotes.length > 0) {
        //deleting old quotes
        await quotesDBHelper.deleteAll();
          listOfQuotes.forEach((quote) {
            quotesDBHelper.save(quote);
          });


        // store last fetch call datatime to make next call after 24Hrs.
        pref.setString("lastSync", currentTime);
        pref.setInt("quotesPageNo", quotesPageNo++);
        print("quotes saved");
      }
    } else {
      //if there is any error on server
      homeScaffold.currentState.showSnackBar(
          new SnackBar(content: Text("There is some on server side!")));
    }
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
