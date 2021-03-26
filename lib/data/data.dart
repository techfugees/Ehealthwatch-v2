import 'package:flutter/material.dart';
import 'package:techfugeesapp/models/models.dart';
import 'package:techfugeesapp/screens/reportcase.dart';
import 'package:techfugeesapp/screens/screens.dart';
// import 'package:techfugeesapp/screens/profile.dart';

const double fontsizexl = 40;
const double fontsizel = 25;
const double fontsize = 12;
const double fontsize1 = 17;
const double fontsize2 = 15;
const double fontsize3 = 13;
const double fontsize4 = 11;
List reportcontent = [];
List<ServicesModel> services = [
  // ServicesModel(
  //     onPress: (context) {
  //       print('Report Case');
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (BuildContext context) {
  //         return ReportCase();
  //       }));
  //     },
  //     id: '1',
  //     name: 'Report Cases',
  //     imageurl:
  //         'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80',
  //     isactive: true),
  ServicesModel(
      onPress: (context) {
        print('Report Case');
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return AudioRec();
        }));
      },
      id: '2',
      name: 'Prescription',
      imageurl:
          'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80',
      isactive: true),
  ServicesModel(
      id: '3',
      name: 'Reminders',
      imageurl:
          'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80',
      isactive: true),
  ServicesModel(
      id: '4',
      name: 'Article',
      imageurl:
          'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80',
      isactive: true),
  ServicesModel(
      id: '5',
      name: 'Analytics',
      imageurl:
          'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80',
      isactive: true),
];
