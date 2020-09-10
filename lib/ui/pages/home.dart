import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:renesis_tech/controllers/cHome.dart';
import 'package:renesis_tech/ui/helperWidgets/colors.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final _CHome = Provider.of<CHome>(context, listen: false);
    List<Widget> _pages = <Widget>[
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: themBlack,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    height: ScreenUtil().setHeight(130),
                    width: ScreenUtil().setWidth(130),
                    child: Center(
                      child: Transform(
                        transform: Matrix4.rotationY(math.pi),
                        alignment: Alignment.center,
                        child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationX(math.pi),
                            child: Icon(
                              Icons.format_quote,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Qreads",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(70),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(70)),
                child: Text("Latest",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(55),
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                // color: Colors.red,
                height: ScreenUtil().setHeight(1000),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Consumer<CHome>(
                  builder: (BuildContext context, CHome value, Widget child) {
                    return _CHome.loadingQuotes
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : (_CHome.listOfQuotes != null &&
                                _CHome.listOfQuotes.length > 0)
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 10,right: 10, top: 20,bottom: 30),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.15),
                                            blurRadius:
                                                25.0, // soften the shadow
                                            spreadRadius:
                                                1.0, //extend the shadow
                                            offset: Offset(
                                              5.0, // Move to right 10  horizontally
                                              5.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white),
                                    width: ScreenUtil().setWidth(550),
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(90),
                                        bottom: ScreenUtil().setHeight(90),
                                        left: ScreenUtil().setWidth(50)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                         left:10,
                                          child: Icon(
                                            Icons.format_quote,
                                            color: Colors.black.withOpacity(0.05),
                                            size: ScreenUtil().setHeight(600),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Quotes",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Text(_CHome.listOfQuotes[index].quoteText),
                                            Text(
                                                "___  " +
                                                    _CHome.listOfQuotes[index].quoteAuthor,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: _CHome.listOfQuotes.length,
                              )
                            : Center(child: Text("No data available "));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                child: Text("Favorites",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(55),
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(45),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.black.withOpacity(0.05))),
                  height: 140,
                  width: double.infinity,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/images/stevejobs.jpg')))
            ],
          ),
        ),
      ),
      Center(
        child: Text('Page 2'),
      ),
      Center(
        child: Text('Page 3'),
      ),
      Center(
        child: Text('Page 4'),
      ),
      Center(
        child: Text('Page 5'),
      )
    ];
    return Scaffold(
      key: _CHome.homeScaffold,
      body: Container(
          // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Consumer<CHome>(
        builder: (BuildContext context, value, Widget child) {
          return _pages.elementAt(value.selectedIndex);
        },
      )),
      bottomNavigationBar: Consumer<CHome>(
        builder: (BuildContext context, CHome value, Widget child) {
          return Container(
            child: BottomNavigationBar(
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.border_all),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    title: Text('Page 2'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_box),
                    title: Text('Page 3'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    title: Text('Page 4'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text("Account"),
                  ),
                ],
                currentIndex: _CHome.selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black.withOpacity(0.6),
                onTap: _CHome.onItemTapped),
          );
        },
      ),
    );
  }
}
