import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/screens/screens.dart';
import 'package:techfugeesapp/theme/theme.dart';

class NoConnection extends StatelessWidget {
  final String message;

  const NoConnection({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .3,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              child: Icon(
                Icons.wifi_off,
                size: 90,
                color: Color(0xffa5a5a5),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Center(
                child: Text(
                  '$message',
                  style: GoogleFonts.raleway(
                      // textStyle: TextStyle(color: Color(0xffa5a5a5)),
                      fontSize: fontsize1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: RaisedButton(
                    elevation: 0,
                    color: maincolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      "TRY AGAIN",
                      style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: backgroundcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.topToBottom,
                            child: IntroScreen(),
                          ));
                    },
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
