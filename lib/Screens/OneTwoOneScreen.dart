import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class OneTwoOneScreen extends StatefulWidget {
  @override
  _OneTwoOneScreenState createState() => _OneTwoOneScreenState();
}

class _OneTwoOneScreenState extends State<OneTwoOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "No Data Found",
          style: TextStyle(color: appPrimaryMaterialColor, fontSize: 20),
        ),
      ),
    );
  }
}
