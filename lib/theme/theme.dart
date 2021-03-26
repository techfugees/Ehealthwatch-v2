import 'package:flutter/material.dart';

var backgroundcolor = Color(0xfff7f7fa);
var iconcolor = Color(0xffefefef);
var fontcolor = Color(0xff2c2c2c);
var maincolor2 =Color(0xffb43309);
var maincolor = Color(0xff239689);
var cardcolors = Color(0xfff5f5f5);
ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: backgroundcolor,
    primaryColor: maincolor,
    // iconTheme: IconThemeData(color: iconcolor),
    appBarTheme: AppBarTheme(
      color: backgroundcolor,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color:maincolor),
      textTheme: TextTheme(
        headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
