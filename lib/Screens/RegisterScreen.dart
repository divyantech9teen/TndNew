import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';

import 'VerificationScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController txtOTP = new TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtReferalCode = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  final _formkey = new GlobalKey<FormState>();
  bool isLoading = false;
  String rndNumber;

  saveDataToSession(var data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.CustomerId, data["_id"].toString());
    await prefs.setString(Session.CustomerName, data["name"]);
    await prefs.setString(Session.CustomerCompanyName, data["company_name"]);
    await prefs.setString(Session.CustomerEmailId, data["email"]);
    await prefs.setString(Session.CustomerPhoneNo, data["mobile"]);
    await prefs.setString(Session.ismember, data["ismember"].toString());
    await prefs.setString(Session.referred_by, data["referred_by"]);
    Navigator.pushNamedAndRemoveUntil(
        context, '/RegistrationProfileScreen', (route) => false);
    Fluttertoast.showToast(msg: "Register Successfully!!!!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 10,
              ),
              Image.asset(
                "assets/LOGO1.png",
                height: 200,
                width: 250,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: txtName,
                  style: TextStyle(fontSize: 15),
                  cursorColor: appPrimaryMaterialColor,
                  validator: (name) {
                    if (name.length == 0) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                        top: 1.0, bottom: 1, left: 10, right: 1),
                    hintText: "Enter your Name",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: appPrimaryMaterialColor[400]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: appPrimaryMaterialColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: txtMobileNumber,
                    style: TextStyle(fontSize: 15),
                    cursorColor: appPrimaryMaterialColor,
                    maxLength: 10,
                    validator: (phone) {
                      Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                      RegExp regExp = new RegExp(pattern);
                      if (phone.length == 0) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(phone)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.only(
                          top: 1.0, bottom: 1, left: 10, right: 1),
                      hintText: "Enter Mobile No",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                  style: TextStyle(fontSize: 15),
                  cursorColor: appPrimaryMaterialColor,
                  validator: (email) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    print(email);
                    if (email.isEmpty) {
                      return 'Please enter email';
                    } else {
                      if (!regex.hasMatch(email))
                        return 'Enter valid Email Address';
                      else
                        return null;
                    }
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                        top: 1.0, bottom: 1, left: 10, right: 1),
                    hintText: "Enter Email",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: appPrimaryMaterialColor[400]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: appPrimaryMaterialColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: txtCName,
                  style: TextStyle(fontSize: 15),
                  cursorColor: appPrimaryMaterialColor,
                  validator: (cname) {
                    if (cname.length == 0) {
                      return 'Please enter your Company Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                        top: 1.0, bottom: 1, left: 10, right: 1),
                    hintText: "Enter Company Name",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: appPrimaryMaterialColor[400]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: appPrimaryMaterialColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: txtReferalCode,
                  style: TextStyle(fontSize: 15),
                  cursorColor: appPrimaryMaterialColor,
                  // validator: (cname) {
                  //   if (cname.length == 0) {
                  //     return 'Please enter your Company Name';
                  //   }
                  //   return null;
                  // },
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                        top: 1.0, bottom: 1, left: 10, right: 1),
                    hintText: "Enter Referral Code ",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: appPrimaryMaterialColor[400]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: appPrimaryMaterialColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: RaisedButton(
                      color: appPrimaryMaterialColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        if (isLoading == false) _registration();

//                      Navigator.of(context)
//                          .pushReplacementNamed('/LoginScreen');
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                          : Text("REGISTER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* _sendOTP() async {
    var rnd = new Random();
    setState(() {
      rndNumber = "";
    });

    for (var i = 0; i < 4; i++) {
      rndNumber = rndNumber + rnd.nextInt(9).toString();
    }
    print(rndNumber);
    Fluttertoast.showToast(
        msg: "OTP send successfully", gravity: ToastGravity.BOTTOM);
  }*/
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text(
            "You are already register, please login...",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Ok",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/LoginScreen', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  _registration() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          var body = {
            "name": txtName.text,
            "mobile": txtMobileNumber.text.toString(),
            "email": txtEmail.text,
            "company_name": txtCName.text,
            "refralcode": txtReferalCode.text,
            //"referred_by": "",
          }; //"key":"value"
          Services.PostForList(api_name: 'api/registration', body: body).then(
              (responseList) async {
            setState(() {
              isLoading = false;
            });
            if (responseList.length > 0) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VerificationScreen(
                        mobile: txtMobileNumber.text,
                        logindata: responseList[0],
                        onLoginSuccess: () {
                          saveDataToSession(responseList[0]);
                        },
                      )));
            } else {
              _showDialog(context);
              Fluttertoast.showToast(msg: "Registration Fail!!!!");
              //showMsg(data.Message); //show "data not found" in dialog
            }
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "Something Went Wrong");
            //showMsg("something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill all the fields...");
    }
  }
}
