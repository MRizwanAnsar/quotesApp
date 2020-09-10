import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renesis_tech/ui/pages/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: App(),
    );
  }
}

