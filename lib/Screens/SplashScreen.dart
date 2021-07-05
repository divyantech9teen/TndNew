import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: appPrimaryMaterialColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/LOGO1.png',
                    fit: BoxFit.contain,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 40),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: new Container(
                      child: Text(''),
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        border: Border.all(color: appPrimaryMaterialColor),
                        //color: appPrimaryMaterialColor, // border color
                        shape: BoxShape.circle,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0, left: 0),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: new Container(
                      child: Text(''),
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        border: Border.all(color: appPrimaryMaterialColor),
                        //color: appPrimaryMaterialColor, // border color
                        shape: BoxShape.circle,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 300.0, right: 40),
              child: Align(
                  alignment: Alignment.topRight,
                  child: new Container(
                      child: Text(''),
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        border: Border.all(color: appPrimaryMaterialColor),
                        //color: appPrimaryMaterialColor, // border color
                        shape: BoxShape.circle,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 170.0, left: 40),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: new Container(
                      child: Text(''),
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        border: Border.all(color: appPrimaryMaterialColor),
                        //color: appPrimaryMaterialColor, // border color
                        shape: BoxShape.circle,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 300.0, left: 0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: new Container(
                      child: Text(''),
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        border: Border.all(color: appPrimaryMaterialColor),
                        //color: appPrimaryMaterialColor, // border color
                        shape: BoxShape.circle,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0, right: 40),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: new Container(
                      child: Text(''),
                      height: 10,
                      width: 10,
                      decoration: new BoxDecoration(
                        border: Border.all(color: appPrimaryMaterialColor),
                        //color: appPrimaryMaterialColor, // border color
                        shape: BoxShape.circle,
                      ))),
            )
          ],
        ));
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MobileNumber = prefs.getString(Session.CustomerPhoneNo);
      String Type = prefs.getString(Session.type);
      print(Type);
      print(MobileNumber);
      if (MobileNumber == null) {
        //Navigator.pushReplacementNamed(context, '/LoginScreen');
        Navigator.pushReplacementNamed(context, '/GuestDashBoard');
      } else {
        Navigator.pushReplacementNamed(context, '/HomePage');
      }
    });
  }
}
