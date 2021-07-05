import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';

class NotificationInquiry extends StatefulWidget {
  var message;

  NotificationInquiry({this.message});

  @override
  _NotificationInquiryState createState() => _NotificationInquiryState();
}

class _NotificationInquiryState extends State<NotificationInquiry> {
  bool isSendLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.message["notification"]["title"]}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.message["notification"]["body"]}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.grey[800]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5, top: 15, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    color: appPrimaryMaterialColor,
                    child: isSendLoading == true
                        ? LoadingComponent()
                        : Text(
                            "Accept",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                    onPressed: () {
                      _sendRequest();
                      Navigator.of(context).pop();
                    },
                  ),
                  Container(
                    width: 2,
                    color: appPrimaryMaterialColor,
                    height: 35,
                  ),
                  new FlatButton(
                    color: appPrimaryMaterialColor,
                    child: isSendLoading == true
                        ? LoadingComponent()
                        : Text(
                            "Reject",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                    onPressed: () async {
                      // print(
                      //     "=======================>${widget.message["requestReceiver"]}======================>${widget.message["requestSender"]}");
                      // _sendRequest("rejected");
                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                      Navigator.pop(context);
                      // await prefs.clear();
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, '/LoginScreen', (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendRequest() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isSendLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "byUser": "${widget.message["data"]["senerID"]}",
          "toUser": "${widget.message["data"]["ReceiverId"]}",
          //"requestStatus": status,
          // "notificationData": {
          //   "notificationBody": "Hi " +
          //       ", "
          //           "${prefs.getString(Session.CustomerName)} has " +
          //       status +
          //       " your request",
          //   "notificationTitle": "${widget.message["notification"]["title"]}",
          // },
        };
        print("======================${body}");
        Services.postForSave(apiname: 'admin/accpetuserinquiry', body: body)
            .then((response) async {
          print("jjjjj");
          if (response.IsSuccess == true && response.Data == "1") {
            setState(() {
              isSendLoading = false;
            });
            Fluttertoast.showToast(msg: response.Message);
          }
        }, onError: (e) {
          setState(() {
            isSendLoading = false;
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
