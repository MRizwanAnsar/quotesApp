import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renesis_tech/models/quote.dart';
import 'package:sqflite/sqflite.dart';

class QuotesDBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String QUOTE = 'quote';
  static const String AUTHER = 'auther';
  static const String TABLE = 'quotes';
  static const String DB_NAME = 'quotesAppdb.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$QUOTE TEXT ,$AUTHER TEXT)");
  }

  Future save(Quotes quote) async {
    var dbClient = await db;
    //replace all single quotes "'" to avoid query break .
    var cleanQuote = quote.quoteText.replaceAll("'", "''");
    var cleanAuthor = quote.quoteAuthor.replaceAll("'", "''");
    var query =
        "INSERT INTO $TABLE ($QUOTE,$AUTHER) VALUES ('${cleanQuote}','${cleanAuthor}')";
    await dbClient.execute(query);
  }

  Future<List<Quotes>> getallQuotes() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [QUOTE, AUTHER]);
    List<Quotes> listOfQuotes = new List<Quotes>();
    for (var i = 0; i < maps.length; i++) {
      listOfQuotes.add(new Quotes(quoteText:maps[i][QUOTE], quoteAuthor:maps[i][AUTHER]));
    }
    return listOfQuotes;
  }

  Future deleteAll() async {
    var dbClient = await db;
    return await dbClient.delete(TABLE);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
