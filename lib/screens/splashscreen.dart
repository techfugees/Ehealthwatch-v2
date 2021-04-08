import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techfugeesapp/components/components.dart';
import 'package:techfugeesapp/theme/theme.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SharedPreferences prefs;
  @override
  void initState() {
    getToken().then((token) => Timer(
        Duration(seconds: 5),
        () => token == null
            ? MyNavigator.goToLogin(context)
            : MyNavigator.goToHomePage(context, token)));
    super.initState();
  }

  getToken() async {
    prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token'));

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
          ),
          // SizedBox(height: 50),
          Align(
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset('assets/logo2.png',width: 250,height: 150,)),
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Health E-Watch App \nSupported by Kenya Red Cross and TechFugees',textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: fontcolor,
                      fontStyle: FontStyle.italic,
                      fontSize: 11,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
