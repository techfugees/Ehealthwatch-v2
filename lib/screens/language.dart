import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:techfugeesapp/components/components.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/models/models.dart';
import 'package:techfugeesapp/theme/theme.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  int _character = 0;
  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _character == 0 ? "Choose Language" : "Chagua Lugha",
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
                  fontSize: fontsize1,
                  color: fontcolor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      backgroundColor: backgroundcolor,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .16,
          ),
          RadioListTile<int>(
            title: Text(
              "English",
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      fontSize: fontsize1,
                      color: fontcolor,
                      fontWeight: FontWeight.bold)),
            ),
            value: 0,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<int>(
            title: Text(
              "Kiswahili",
              style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      fontSize: fontsize1,
                      color: fontcolor,
                      fontWeight: FontWeight.bold)),
            ),
            value: 1,
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value;
              });
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * .13,
          ),
          Align(
            alignment: Alignment.topLeft,
            // padding: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  print(_character);
                  if (_character == 0) {
                    setState(() {
                      appstate.isenglish = true;
                    });
                    MyNavigator.goToLoginPage(context);
                  } else {
                    setState(() {
                      appstate.isenglish = false;
                    });
                    MyNavigator.goToLoginPage(context);
                  }
                },
                child: Container(
                  height: 50.00,
                  width: MediaQuery.of(context).size.width * .7,
                  decoration: BoxDecoration(
                    color: maincolor,
                    borderRadius: BorderRadius.circular(5.00),
                  ),
                  child: Center(
                    child: Text(
                      _character == 0 ? "CONTINUE..." : "ENDELEA ...",
                      style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: backgroundcolor,
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
