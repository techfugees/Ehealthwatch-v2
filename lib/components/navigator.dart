import 'package:flutter/material.dart';
import 'package:techfugeesapp/screens/screens.dart';

class MyNavigator {
  static goToLogin(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    }));
  }

  static goToHomePage(BuildContext context, String phonenumber) {

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return ReportCase(
        phonenumber:  phonenumber
            
      );
    }));
  }
}
