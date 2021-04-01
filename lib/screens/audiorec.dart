import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medcorder_audio/medcorder_audio.dart';

class AudioRec extends StatefulWidget {
  @override
  _AudioRecState createState() =>  _AudioRecState();
}

class _AudioRecState extends State<AudioRec> {
  MedcorderAudio audioModule =  MedcorderAudio();
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
      DateTime time =  DateTime.now();
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
      // String url = event['url'];
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

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        appBar:  AppBar(
          title:  Text('Audio example app'),
        ),
        body:  Center(
          child: canRecord
              ?  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     InkWell(
                      child:  Container(
                        alignment: FractionalOffset.center,
                        child:  Text(isRecord ? 'Stop' : 'Record'),
                        height: 40.0,
                        width: 200.0,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        if (isRecord) {
                          _stopRecord();
                        } else {
                          _startRecord();
                        }
                      },
                    ),
                     Text('recording: ' + recordPosition.toString()),
                     Text('power: ' + recordPower.toString()),
                     InkWell(
                      child:  Container(
                        margin:  EdgeInsets.only(top: 40.0),
                        alignment: FractionalOffset.center,
                        child:  Text(isPlay ? 'Stop' : 'Play'),
                        height: 40.0,
                        width: 200.0,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        if (!isRecord && file.length > 0) {
                          _startStopPlay();
                        }
                      },
                    ),
                     Text('playing: ' + playPosition.toString()),
                  ],
                )
              :  Text(
                  'Microphone Access Disabled.\nYou can enable access in Settings',
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}