import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfugeesapp/data/data.dart';
// import 'package:techfugeesapp/theme/theme.dart';
import 'package:location/location.dart';
  Location locationcustom = new Location();
  bool _serviceEnabled;
class NoLocation extends StatelessWidget {
  void openLocationSetting() async {
    _serviceEnabled = await locationcustom.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationcustom.requestService();
      if (!_serviceEnabled) {
        debugPrint('Location Denied once');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Container(
              // height: MediaQuery.of(context).size.height * .3,
              child: Icon(
                Icons.location_disabled_outlined,
                size: 50,
                color: Color(0xffa5a5a5),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Center(
                child: Text(
                  'Enable Location',
                  style: GoogleFonts.raleway(
                      // textStyle: TextStyle(color: Color(0xffa5a5a5)),
                      fontSize: fontsize1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // SizedBox(height: 20),
            // Container(
            //   child: Center(
            //     child: SizedBox(
            //       width: MediaQuery.of(context).size.width * 0.95,
            //       child: RaisedButton(
            //         elevation: 0,
            //         color: maincolor,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5.0)),
            //         child: Text(
            //           "TRY AGAIN",
            //           style: GoogleFonts.raleway(
            //               textStyle: TextStyle(
            //                   color: backgroundcolor,
            //                   fontSize: fontsize1,
            //                   fontWeight: FontWeight.bold)),
            //         ),
            //         onPressed: () {
            //           print("whatsapp");
            //          openLocationSetting();
            //         },
            //         padding: EdgeInsets.all(16.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
