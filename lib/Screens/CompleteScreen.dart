import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class CompleteScreen extends StatefulWidget {
  var directoryData;
  CompleteScreen({this.directoryData});
  @override
  _CompleteScreenState createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  String reference = "yes";
  TextEditingController txtTopic = TextEditingController();
  bool isLoading = false;

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  String _format = 'yyyy-MMMM-dd';
  DateTime _date = DateTime.now();

  void _showDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _date,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
        });
        print(_date);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Complete 1-2-1 Request",
              style: TextStyle(
                color: appPrimaryMaterialColor,
                fontSize: 18,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
          leading: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[200], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[600].withOpacity(0.2),
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 45,
            child: FlatButton(
              color: appPrimaryMaterialColor[500],
              child: isLoading == true
                  ? LoadingBlueComponent()
                  : Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
              onPressed: () async {
                //SharedPreferences prefs = await SharedPreferences.getInstance();
                _completeRequest();
                Navigator.pop(context);

                // await prefs.clear();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/LoginScreen', (route) => false);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Date : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showDate();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: appPrimaryMaterialColor[500],
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: appPrimaryMaterialColor
                                          .withOpacity(0.2),
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(3.0, 5.0))
                                ]),
                            // decoration: BoxDecoration(
                            //     border:
                            //         Border.all(width: 1, color: Colors.black54),
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(4.0))),
                            child: _date == null
                                ? Center(
                                    child: Text(
                                    'Select Date of Birth',
                                    style: TextStyle(fontSize: 17),
                                  ))
                                : Center(
                                    child: Text(
                                    '${_date.day}/${_date.month}/${_date.year}',
                                    style: TextStyle(fontSize: 17),
                                  ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 20),
                      child: Text("Topic : ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                      child: Container(
                        //height: 130,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          controller: txtTopic,
                          maxLines: 5,
                          maxLength: 400,
                          maxLengthEnforced: true,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(fontSize: 16),
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            counterText: "",
                            contentPadding: EdgeInsets.only(
                                top: 15, bottom: 1, left: 1, right: 1),
                            hintText: "Description",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500),
                            prefixIcon: Icon(
                              Icons.sticky_note_2_outlined,
                              color: appPrimaryMaterialColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: appPrimaryMaterialColor[500]),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: appPrimaryMaterialColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 25),
                      child: Text("Generated Referal : ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 10, right: 20),
                      child: Container(
                        height: 40,
                        child: RadioListTile(
                          activeColor: appPrimaryMaterialColor,
                          groupValue: reference,
                          title: Text("Yes",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          value: 'yes',
                          onChanged: (val) {
                            setState(() {
                              reference = val;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 10, right: 20),
                      child: Container(
                        height: 40,
                        child: RadioListTile(
                          activeColor: appPrimaryMaterialColor,
                          groupValue: reference,
                          title: Text("No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          value: 'no',
                          onChanged: (val) {
                            setState(() {
                              reference = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _completeRequest() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "requestSender": "${prefs.getString(Session.CustomerId)}",
          "requestReceiver": "${widget.directoryData["_id"]}",
          "topic": txtTopic.text,
          "date": _date.toString(),
          "generatedRefral": reference,
          // "notificationData": {
          //   'notificationBody': "Hi " +
          //       ", "
          //           "${prefs.getString(Session.CustomerName)} has " +
          //       status +
          //       " your request",
          //   'notificationTitle':
          //   "${widget.message["notification"]["notificationTitle"]}",
          // },
        };
        Services.postForSave(apiname: 'users/requestcomplete', body: body).then(
            (response) async {
          setState(() {
            isLoading = false;
          });
          if (response.IsSuccess == true && response.Data == "1") {
            Fluttertoast.showToast(msg: response.Message);
            Navigator.of(context).pop();
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }
}
