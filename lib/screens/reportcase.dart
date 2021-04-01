import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/screens/screens.dart';
import 'package:techfugeesapp/theme/theme.dart';

class ReportCase extends StatefulWidget {
  final String phonenumber;

  const ReportCase({Key key, @required this.phonenumber}) : super(key: key);
  @override
  _ReportCaseState createState() => _ReportCaseState();
}

class _ReportCaseState extends State<ReportCase> {
  static TextEditingController conditionController = TextEditingController();
  static TextEditingController symptomController = TextEditingController();
  static TextEditingController datetimecontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String serror = 'No Error Dectected';
  List<Asset> images = [];
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  void showInSnackBar(String value) {}

  MedcorderAudio audioModule = MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";

  @override
  initState() {
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
    });
    _initSettings();
  }

  Future _initSettings() async {
    final String result = await audioModule.checkMicrophonePermissions();
    if (result == 'OK') {
      await audioModule.setAudioSettings();
      setState(() {
        canRecord = true;
      });
    }
    return;
  }

  Future _startRecord() async {
    try {
      DateTime time = DateTime.now();
      setState(() {
        file = time.millisecondsSinceEpoch.toString();
      });
      final String result = await audioModule.startRecord(file);
      setState(() {
        isRecord = true;
      });
      print('startRecord: ' + result);
    } catch (e) {
      file = "";
      print('startRecord: fail');
    }
  }

  Future _stopRecord() async {
    try {
      final String result = await audioModule.stopRecord();
      print('stopRecord: ' + result);
      setState(() {
        isRecord = false;
      });
    } catch (e) {
      print('stopRecord: fail');
      setState(() {
        isRecord = false;
      });
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
    } else {
      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      setState(() {
        recordPower = (60.0 - power.abs().floor()).abs();
        recordPosition = event['currentTime'];
      });
    }
    if (event['code'] == 'playing') {
      String url = event['url'];
      setState(() {
        playPosition = event['currentTime'];
        isPlay = true;
      });
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      setState(() {
        playPosition = 0.0;
        isPlay = false;
      });
    }
  }

  Future<void> loadvariantsAssets() async {
    List<Asset> resultList = [];
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      serror = error;
    });
  }

  Widget builimagevariantsListview() {
    return ListView.separated(
        itemCount: images.length,
        shrinkWrap: true,
        primary: false,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 5,
            ),
        itemBuilder: (BuildContext context, int index) {
          Asset asset = images[index];
          return Container(
            child: AssetThumb(
              asset: asset,
              width: 150,
              height: 150,
            ),
          );
        });
  }

  void submit(BuildContext context) async {
    final formField = formKey.currentState;
    if (formField.validate()) {
      formField.save();
      setState(() {
        isLoading = true;
      });
      showInSnackBar('Just A Minute ...');
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: LocationWidget(
            phonenumber: widget.phonenumber,
            // location: '',
            datetime: datetimecontroller.text,
            symptoms: symptomController.text,
            condition: conditionController.text,
            images: images,
            audio: file,
          ),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });

      showInSnackBar('Ooooh no! Bad Input!');
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Report A Case",
            style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    fontSize: fontsize1,
                    color: fontcolor,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        backgroundColor: backgroundcolor,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: datetimecontroller,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      hintText: 'When Did It Happen?',
                      hintStyle: GoogleFonts.getFont(
                        'Raleway',
                        color: fontcolor,
                        fontSize: 18,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: maincolor,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      value = value.trim();
                      if (value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: conditionController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'What are the Conditions?',
                      hintStyle: GoogleFonts.getFont(
                        'Raleway',
                        color: fontcolor,
                        fontSize: 18,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: maincolor,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      value.trim();
                      if (value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: symptomController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Symptoms?',
                      hintStyle: GoogleFonts.getFont(
                        'Raleway',
                        color: fontcolor,
                        fontSize: 18,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: maincolor,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    validator: (value) {
                      value.trim();
                      if (value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),

                // Padding(
                //   padding: const EdgeInsets.only(left: 12.0),
                //   child: Column(
                //     children: [
                //       Align(
                //         alignment: Alignment.centerLeft,
                //         child: Text(
                //           "Any Images?",
                //           style: GoogleFonts.raleway(
                //               textStyle: TextStyle(
                //                   fontSize: fontsize1,
                //                   color: fontcolor,
                //                   fontWeight: FontWeight.bold)),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 12.0),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: SingleChildScrollView(
                //       scrollDirection: Axis.horizontal,
                //       child: Row(
                //         children: [
                //           GestureDetector(
                //             onTap: loadvariantsAssets,
                //             child: Container(
                //               width: 50,
                //               height: 50,
                //               decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 color: maincolor,
                //               ),
                //               child: Center(
                //                 child: Icon(
                //                   Icons.add,
                //                   color: backgroundcolor,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Container(
                //               height: MediaQuery.of(context).size.height * .16,
                //               decoration: BoxDecoration(
                //                 color: Color(0xfff5f5f5),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     offset: Offset(-3.00, -3.00),
                //                     color: Color(0xffffffff),
                //                     blurRadius: 6,
                //                   ),
                //                 ],
                //                 borderRadius: BorderRadius.circular(6.00),
                //               ),
                //               child: builimagevariantsListview(),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
               
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Column(
                //     children: [
                //       Align(
                //         alignment: Alignment.centerLeft,
                //         child: Text(
                //           "Any Audio?",
                //           style: GoogleFonts.raleway(
                //               textStyle: TextStyle(
                //                   fontSize: fontsize1,
                //                   color: fontcolor,
                //                   fontWeight: FontWeight.bold)),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // canRecord
                //     ? Align(
                //         alignment: Alignment.topLeft,
                //         child: Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Row(
                //             children: [
                //               GestureDetector(
                //                 onTap: () {
                //                   if (isRecord) {
                //                     _stopRecord();
                //                   } else {
                //                     _startRecord();
                //                   }
                //                 },
                //                 child: Container(
                //                   width: 50,
                //                   height: 50,
                //                   decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: isRecord ? maincolor2 : maincolor,
                //                   ),
                //                   child: Center(
                //                     child: Icon(
                //                       isRecord
                //                           ? Icons.keyboard_voice_rounded
                //                           : Icons.keyboard_voice_outlined,
                //                       color: backgroundcolor,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 5,
                //               ),
                //               IconButton(
                //                   icon: isPlay
                //                       ? Icon(Icons.play_arrow_outlined,
                //                           color: maincolor)
                //                       : Icon(Icons.play_disabled),
                //                   onPressed: () {
                //                     if (!isRecord && file.length > 0) {
                //                       _startStopPlay();
                //                     }
                //                   }),
                //               SizedBox(
                //                 width: 5,
                //               ),
                //               Text(
                //                 'TIME: ' + recordPosition.toStringAsFixed(2),
                //                 style: GoogleFonts.raleway(
                //                     textStyle: TextStyle(
                //                   fontSize: fontsize1,
                //                   color: fontcolor,
                //                 )),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     : Text(
                //         'Microphone Access Disabled.\nYou can enable access in Settings',
                //         style: GoogleFonts.raleway(
                //             textStyle: TextStyle(
                //           fontSize: fontsize1,
                //           color: fontcolor,
                //         )),
                //       ),
               
               
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () => submit(context),
                    child: Container(
                      height: 50.00,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(5.00),
                      ),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            : Text(
                                "Continue...",
                                style: GoogleFonts.raleway(
                                    textStyle: TextStyle(
                                        color: backgroundcolor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
