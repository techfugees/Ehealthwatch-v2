import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/models/models.dart';
import 'package:techfugeesapp/screens/screens.dart';
import 'package:techfugeesapp/services/modules.dart';
import 'package:techfugeesapp/theme/theme.dart';

class LocationWidget extends StatefulWidget {
  final String phonenumber;
  final String datetime;
  final String condition;
  final String symptoms;
  // final String locationWidget;
  final dynamic audio;
  final List<Asset> images;

  const LocationWidget(
      {Key key,
      @required this.phonenumber,
      this.images,
      //  this.locationWidget,
      this.audio,
      @required this.datetime,
      @required this.condition,
      @required this.symptoms})
      : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Future<Response> auth;
  bool isLoading = false;

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void submit(BuildContext context, appState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    showInSnackBar('Logging in...');

    auth = request({
      "phone": widget.phonenumber,
      "location": appState.initialPosition.toString(),
      "area": appState.locationController.text,
      ""
      "condition": widget.condition,
      "symptoms": widget.symptoms,
      "l": "English"
    });

    setState(() {
      isLoading = false;
    });
    auth.then((auth) async {
      print(auth.code);
      print('auth.message');
      print(auth.message);
      if (auth.error) {
        showInSnackBar("${auth.message}");
      } else {
        showInSnackBar('Hureee!');
        prefs.setString('token', widget.phonenumber);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: MainPageWidget(),
          ),
        );
      }
    });
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: maincolor),
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        child: Text(
          'Done',
          style: GoogleFonts.nunito(
              color: backgroundcolor,
              fontSize: fontsize1,
              fontWeight: FontWeight.bold),
        ),
        onTap: () {},
      ),
    );
    AlertDialog alert = AlertDialog(
      content: Text(
        'Request Placed Succesfully',
        style: GoogleFonts.nunito(
            color: maincolor, fontSize: fontsize1, fontWeight: FontWeight.bold),
      ),
      // content: Icon(Icons.verified, color: maincolor, size: 70),
      actions: [
        okButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Report A Case",
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
                  fontSize: fontsize1,
                  color: fontcolor,
                  fontWeight: FontWeight.bold)),
        ),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Phone Number : ",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: fontcolor,
                          fontSize: fontsize2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${widget.phonenumber}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: fontsize1,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Date/Time: ",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: fontcolor,
                          fontSize: fontsize2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${widget.datetime}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: fontsize1,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Location:",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: fontcolor,
                          fontSize: fontsize2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      appState.locationController.text == null
                          ? ''
                          : "${appState.locationController.text}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                          color: Colors.grey,
                          fontSize: fontsize1,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => submit(context, appState),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    // height: MediaQuery.of(context).size.height * .06,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: maincolor),
                    child: Center(
                      child: Text(
                        "REQUEST ...",
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: backgroundcolor,
                                fontSize: fontsize3,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * .2),
        ),
      ),
      body: appState.initialPosition == null
          ? NoLocation()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  tilt: 10,
                  bearing: 30,
                  target: appState.initialPosition,
                  zoom: 17.0),
              // onMapCreated: appState.onCreated,
              myLocationEnabled: true,
              trafficEnabled: true,
              liteModeEnabled: false,
              mapType: MapType.normal,
              markers: appState.markers,
              compassEnabled: true,
              onCameraMove: appState.onCameraMove,
            ),
    );
    // : NoLocation();
  }
}
