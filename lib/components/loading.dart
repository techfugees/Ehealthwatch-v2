import 'package:flutter/material.dart';
import 'package:techfugeesapp/theme/theme.dart';

class SmallerScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundcolor,
      child: Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      )),
    );
  }
}
