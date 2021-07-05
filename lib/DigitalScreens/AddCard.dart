import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/Common/Constants.dart' as serv;
import 'package:the_national_dawn/DigitalComponent/ImagePickerHandlerComponent.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

Color colorOne = cnst.appcolor;
Color colorTwo = cnst.buttoncolor;
Color colorThree = Colors.grey[500];

class _AddCardState extends State<AddCard> {
  bool isLoading = false;
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtMobile = new TextEditingController();
  TextEditingController txtCompany = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtRegCode = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String GetRandomNo(int length) {
    String UniqueNo = "";
    var rng = new Random();
    for (var i = 0; i < length; i++) {
      UniqueNo += rng.nextInt(10).toString();
    }
    return UniqueNo;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  MemberSignUp() async {
    if (txtName.text != '' &&
        txtMobile.text != '' &&
        txtCompany.text != '' &&
        txtEmail.text != '') {
      setState(() {
        isLoading = true;
      });

      String img = '';
      String referCode =
          txtName.text.substring(0, 3).toUpperCase() + GetRandomNo(5);

      if (_image != null) {
        List<int> imageBytes = await _image.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        img = base64Image;
      }
      print('base64 Img : $img');
      print('RefferCode : $referCode');

      var data = {
        'type': 'signup',
        'name': txtName.text,
        'mobile': txtMobile.text,
        'company': txtCompany.text,
        'email': txtEmail.text,
        'imagecode': img,
        'myreferCode': referCode,
        'regreferCode': txtRegCode.text
      };

      Future res = Services.MemberSignUp(data);
      res.then((data) async {
        setState(() {
          isLoading = false;
        });
        if (data != null && data.ERROR_STATUS == false) {
          Fluttertoast.showToast(
            msg: "Data Saved",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP,
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove(serv.Session.digital_Id);
          await prefs.remove(cnst.Session.Name);
          await prefs.remove(cnst.Session.Mobile);
          await prefs.remove(cnst.Session.Company);
          Navigator.pushNamed(context, "/MobileLogin");
        } else {
          Fluttertoast.showToast(
              msg: "Data Not Saved" + data.MESSAGE,
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              toastLength: Toast.LENGTH_LONG);
        }
      }, onError: (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Data First",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Make New Card"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          border: new Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: txtName,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity),
                            hintText: "Name"),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                      ),
                      //height: 40,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          border: new Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: txtMobile,
                        maxLength: 10,
                        decoration: InputDecoration(
                            counterText: "",
                            prefixIcon: Icon(Icons.phone_android),
                            hintText: "Mobile"),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                      ),
                      //height: 40,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          border: new Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: txtCompany,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.business_center),
                            hintText: "Company"),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black),
                      ),
                      //height: 40,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          border: new Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: txtEmail,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.local_post_office),
                            hintText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                      ),
                      //height: 40,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          border: new Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: txtRegCode,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.device_hub),
                            hintText: "Referral Code"),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                      ),
                      //height: 40,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      margin: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          elevation: 5,
                          textColor: Colors.white,
                          color: cnst.buttoncolor,
                          child: setUpButtonChild(),
                          onPressed: () {
                            MemberSignUp();
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (isLoading == false) {
      return new Text(
        "Save",
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }
}
