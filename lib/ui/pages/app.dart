import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:renesis_tech/controllers/cHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Menu(),
          MultiProvider(providers: [
            ChangeNotifierProvider<CHome>(
              create: (context) => CHome(),
            )
          ], child: Home())
        ],
      ),
    );
  }


}
