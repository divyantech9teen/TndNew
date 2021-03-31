import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';
import 'package:the_national_dawn/Screens/EventTicketScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarDetailScreen extends StatefulWidget {
  var eventData;

  CalendarDetailScreen({this.eventData});

  @override
  _CalendarDetailScreenState createState() => _CalendarDetailScreenState();
}

class _CalendarDetailScreenState extends State<CalendarDetailScreen> {
  String customerId;

  @override
  void initState() {
    _profile();
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customerId = prefs.getString(Session.CustomerId);
    });
  }

  bool isregister = false;
  List eventRegisterList = [];

  void launchwhatsapp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  launchSocialMediaUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "Event Detail",
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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Center(
              child: Text(
                "${widget.eventData["eventName"]}",
                style: TextStyle(
                    fontSize: 20,
                    color: appPrimaryMaterialColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20),
            child: Row(
              children: [
                Text(
                  "Organized by : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${widget.eventData["eventOrganiseBy"]}",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 20),
            child: Row(
              children: [
                Text(
                  "Date : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${widget.eventData["startDate"][0] + "  To  " + widget.eventData["endDate"][0]}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 20),
            child: Row(
              children: [
                Text(
                  "Time : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${widget.eventData["startTime"]}" +
                      "-" +
                      "${widget.eventData["endTime"]}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 20),
            child: Row(
              children: [
                Text(
                  "City : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "${widget.eventData["city"]["City"]}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
            child: Image.network(
              "${widget.eventData['eventImage']}",
              width: MediaQuery.of(context).size.width,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),
          /*Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 20),
                  child: Text(
                    "Description : ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ),*/
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Text(
              "Event Description : ",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
            child: Text(
              "${widget.eventData["description"]}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 20, right: 20),
            child: SocialMediaComponent(
              facebook: widget.eventData["faceBook"],
              instagram: widget.eventData["instagram"],
              linkedIn: widget.eventData["linkedIn"],
              twitter: widget.eventData["twitter"],
              whatsapp: widget.eventData["whatsApp"],
            ),
            /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5, bottom: 5),
                            child: Image.asset(
                              'assets/face.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5, bottom: 5),
                            child: Image.asset(
                              'assets/insta.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5, bottom: 5),
                            child: Image.asset(
                              'assets/link.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5, bottom: 5),
                            child: Image.asset(
                              'assets/whats.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5, bottom: 5),
                            child: Image.asset(
                              'assets/youtu.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey[300], width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5, top: 5, bottom: 5),
                            child: Image.asset(
                              'assets/twit.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/
          ),
          /*  Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 40,
                  child: RaisedButton(
                      color: appPrimaryMaterialColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        _registerEvent();
                      },
                      child: isregister
                          ? LoadingComponent()
                          : Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text("Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17)),
                            )),
                ),
              ),
            ),
          ),*/
        ]),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: appPrimaryMaterialColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: RaisedButton(
                color: appPrimaryMaterialColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  _registerEvent();
                },
                child: isregister
                    ? LoadingComponent()
                    : Text("REGISTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17))),
          ),
        ),
      ),
    );
  }

  _registerEvent() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isregister = true;
        });
        var body = {
          "eventid": widget.eventData["_id"],
          "userid": "${customerId}"
        };
        print(body);
        Services.PostForList(api_name: 'admin/eventRegister', body: body).then(
            (responseList) async {
          setState(() {
            isregister = false;
          });
          if (responseList.length > 0) {
            setState(() {
              eventRegisterList = responseList;
            });
            Fluttertoast.showToast(msg: "You are register successfully...!");
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventTicketScreen(
                        ticketdata: widget.eventData,
                      )),
            );
            Fluttertoast.showToast(msg: "Already Register");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isregister = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
//  Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => EventTicketScreen(
//                           ticketdata: widget.eventData,
//                         )),
//               );
