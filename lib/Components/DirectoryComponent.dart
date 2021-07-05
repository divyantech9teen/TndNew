import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/DirectoryProfileComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';
import 'package:the_national_dawn/Screens/CompleteScreen.dart';
import 'package:the_national_dawn/Screens/EnquiryForm.dart';
import 'package:the_national_dawn/Screens/RequestScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:the_national_dawn/Global.dart' as global;

class DirectoryComponent extends StatefulWidget {
  var directoryData;

  DirectoryComponent({this.directoryData});

  @override
  _DirectoryComponentState createState() => _DirectoryComponentState();
}

class _DirectoryComponentState extends State<DirectoryComponent> {
  List list;
  String isMember;

  _isMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMember = prefs.getString(Session.ismember);
  }

  launchSocialMediaUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }

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

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertSend(
          directoryData: widget.directoryData,
        );
      },
    );
  }

  _showDialogFormember(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
        title: Text("The National Dawn"),
        content: Text("Please subscribe for more networking"),
        actions: [okButton]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return alert;
      },
    );
  }

  _showDialogComplete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertComplete(
          directoryData: widget.directoryData,
        );
      },
    );
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String fcmToken = "";

  @override
  void initState() {
    // TODO: implement initState
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
      print('----------->' + '${token}');
    });
    _isMember();
    super.initState();
  }

  /*
  @override
  void initState() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
      print('----------->' + '${token}');
    });
    _isMember();
    print("SUNNY MORI");
  }*/
  bool isLoading = false;
  updateCount() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "userid": await prefs.getString(Session.CustomerId),
        };
        print(body);
        Services.memberCount(body).then((responselist) async {
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              print("response000000000000000000000000");
              print(responselist);
            });
            // saveDataToSession(responselist[0]);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => VerificationScreen(
            //           mobile: txtMobileNumber.text,
            //           logindata: responselist[0],
            //           onLoginSuccess: () {
            //             saveDataToSession(responselist[0]);
            //           },
            //         )));
            /*  Navigator.of(context).pushNamed('/HomePage');*/
          } else {
            setState(() {
              isLoading = false;
            });
            //  _showDialog(context);
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        global.membercount += 1;
        updateCount();
        print("globalpppppppppppppppppppppppppppp");
        print(global.membercount);
        isMember == "true" || (isMember == "false" && global.membercount <= 3)
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new DirectoryProfileComponent(
                      directoryData: widget.directoryData,
                    )))
            : _showDialogFormember(context);
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, bottom: 22, left: 12, right: 12),
        child: Container(
          height: 190,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[100], width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400].withOpacity(0.2),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: Offset(3.0, 5.0))
              ]),
          child: Row(
            children: [
              Container(
                width: 130,
                height: 210,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey[100]),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${widget.directoryData["img"]}",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.directoryData["name"]}",
                        // widget.directoryData["name"],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${widget.directoryData["company_name"]}",
                        // widget.directoryData["name"],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child:
                            widget.directoryData["businessCategory"].length == 0
                                ? Text("")
                                : Text(
                                    "${widget.directoryData["businessCategory"][0]["categoryName"]}",
                                    //widget.directoryData["business_category"],
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "${widget.directoryData["status"]}" == "send"
                                ? GestureDetector(
                                    onTap: () {
                                      global.membercount += 1;
                                      updateCount();
                                      print(
                                          "globalpppppppppppppppppppppppppppp");
                                      print(global.membercount);
                                      isMember == "true" ||
                                              (isMember == "false" &&
                                                  global.membercount <= 3)
                                          ? _showDialog(context)
                                          : _showDialogFormember(context);
                                    },
                                    child: Container(
                                      height: 25,
                                      // width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: appPrimaryMaterialColor[100],
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/videocall.png'),
                                          FittedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0),
                                              child: Text(
                                                "Send 1-2-1  ",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : "${widget.directoryData["status"]}" ==
                                        "requested"
                                    ? Container(
                                        height: 25,
                                        // width: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  appPrimaryMaterialColor[100],
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/videocall.png'),
                                            FittedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: Text(
                                                  "Requested ",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "${widget.directoryData["status"]}" == "accepted"
                                ? Container(
                                    height: 25,
                                    // width: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: appPrimaryMaterialColor[100],
                                          width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/videocall.png'),
                                        FittedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(
                                              "Accepted  ",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : "${widget.directoryData["status"]}" ==
                                        "rejected"
                                    ? Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            // width: 140,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      appPrimaryMaterialColor[
                                                          100],
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/videocall.png'),
                                                FittedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: Text(
                                                      "Rejected  ",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialog(context);
                                            },
                                            child: Container(
                                              height: 25,
                                              // width: 140,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        appPrimaryMaterialColor[
                                                            100],
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/videocall.png'),
                                                  FittedBox(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 3.0),
                                                      child: Text(
                                                        "Send Again  ",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                            "${widget.directoryData["status"]}" == "accepted"
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // _showDialogComplete(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new CompleteScreen(
                                                          directoryData: widget
                                                              .directoryData,
                                                        )));
                                      },
                                      child: Container(
                                        height: 25,
                                        // width: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  appPrimaryMaterialColor[100],
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/videocall.png'),
                                            FittedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0),
                                                child: Text(
                                                  "Completed ",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      /* FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            height: 25,
                            // width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: appPrimaryMaterialColor[100],
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/videocall.png'),
                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      "Send 1-2-1 request ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),*/

                      /* GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RequestScreen()),
                          );
                        },
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 25,
                              // width: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: appPrimaryMaterialColor[100],
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/hand-shake.png',
                                    color: appPrimaryMaterialColor,
                                  ),
                                  FittedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 3),
                                      child: Text(
                                        "Send 1-2-1 request",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),*/

                      widget.directoryData["inquireData"].length == 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new EnquiryForm(
                                            directoryId:
                                                widget.directoryData["_id"],
                                          )));
                                },
                                child: Container(
                                  height: 25,
                                  // width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: appPrimaryMaterialColor[100],
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Image.asset('assets/videocall.png'),
                                      //  Icon(Icons.format_list_bulleted_sharp),
                                      FittedBox(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Text(
                                            "Enquiry Form  ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : widget.directoryData["inquireData"].length > 0
                              ? widget.directoryData["inquireData"][0]
                                          ["status"] ==
                                      false
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new EnquiryForm(
                                                            directoryId: widget
                                                                    .directoryData[
                                                                "_id"],
                                                          )));
                                        },
                                        child: Container(
                                          height: 25,
                                          // width: 140,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: appPrimaryMaterialColor[
                                                    100],
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Image.asset('assets/videocall.png'),
                                              FittedBox(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0),
                                                  child: Text(
                                                    "Enquiry Form  ",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              launchwhatsapp(
                                                  phone: "+91" +
                                                      widget.directoryData[
                                                          "whatsApp"],
                                                  message: "");
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Container(
                                                height: 30,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.grey[200],
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey[600]
                                                              .withOpacity(0.2),
                                                          blurRadius: 1.0,
                                                          spreadRadius: 1.0,
                                                          offset:
                                                              Offset(3.0, 5.0))
                                                    ]),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0,
                                                          right: 3,
                                                          top: 3,
                                                          bottom: 3),
                                                  child: Image.asset(
                                                      'assets/whats.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _launchURL(
                                                  widget.directoryData["email"],
                                                  '',
                                                  '');
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Container(
                                                height: 30,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey[300],
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Image.asset(
                                                      'assets/gmail.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              launch(
                                                  ('tel:// ${widget.directoryData["mobile"]}'));
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey[300],
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
//                                boxShadow: [
//                                  BoxShadow(
//                                      color: Colors.grey[600].withOpacity(0.2),
//                                      blurRadius: 1.0,
//                                      spreadRadius: 1.0,
//                                      offset: Offset(3.0, 5.0))
//                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0,
                                                    right: 4,
                                                    top: 4,
                                                    bottom: 4),
                                                child: Image.asset(
                                                  'assets/phone-call.png',
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                              : Container(),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10.0),
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 launchwhatsapp(
//                                     phone: "+91" +
//                                         widget.directoryData["whatsApp"],
//                                     message: "");
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(right: 15.0),
//                                 child: Container(
//                                   height: 30,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: Colors.grey[200], width: 1),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.grey[600]
//                                                 .withOpacity(0.2),
//                                             blurRadius: 1.0,
//                                             spreadRadius: 1.0,
//                                             offset: Offset(3.0, 5.0))
//                                       ]),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 3.0, right: 3, top: 3, bottom: 3),
//                                     child: Image.asset('assets/whats.png'),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 _launchURL(
//                                     widget.directoryData["email"], '', '');
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(right: 15.0),
//                                 child: Container(
//                                   height: 30,
//                                   width: 40,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: Colors.grey[300], width: 1),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10.0)),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 4.0, right: 4, top: 5, bottom: 5),
//                                     child: Image.asset('assets/gmail.png'),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 launch(
//                                     ('tel:// ${widget.directoryData["mobile"]}'));
//                               },
//                               child: Container(
//                                 height: 30,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       color: Colors.grey[300], width: 1),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0)),
// //                                boxShadow: [
// //                                  BoxShadow(
// //                                      color: Colors.grey[600].withOpacity(0.2),
// //                                      blurRadius: 1.0,
// //                                      spreadRadius: 1.0,
// //                                      offset: Offset(3.0, 5.0))
// //                                ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 4.0, right: 4, top: 4, bottom: 4),
//                                   child: Image.asset(
//                                     'assets/phone-call.png',
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
                      /*Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new DirectoryProfileComponent(
                                      directoryData: widget.directoryData,
                                    )));
                          },
                          child: Container(
                            height: 25,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: appPrimaryMaterialColor[100], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.more_vert,
                                  color: appPrimaryMaterialColor,
                                ),
                                Text(
                                  "View details",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class AlertSend extends StatefulWidget {
  var directoryData;

  AlertSend({this.directoryData});

  @override
  _AlertSendState createState() => _AlertSendState();
}

class _AlertSendState extends State<AlertSend> {
  String requestType = "physical";
  TextEditingController txtOnlineLink = TextEditingController();
  bool isSendLoading = false;
  bool isLoading = false;
  updateCount() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "userid": await prefs.getString(Session.CustomerId),
        };
        print(body);
        Services.memberCount(body).then((responselist) async {
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              print("response000000000000000000000000");
              print(responselist);
            });
            // saveDataToSession(responselist[0]);
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => VerificationScreen(
            //           mobile: txtMobileNumber.text,
            //           logindata: responselist[0],
            //           onLoginSuccess: () {
            //             saveDataToSession(responselist[0]);
            //           },
            //         )));
            /*  Navigator.of(context).pushNamed('/HomePage');*/
          } else {
            setState(() {
              isLoading = false;
            });
            // _showDialog(context);
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Send 1-2-1 Request",
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
      content: new Wrap(
        children: [
          SingleChildScrollView(
            child: ListTile(
              title: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: requestType,
                      title: Text("Physical-Meeting",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      value: 'physical',
                      onChanged: (val) {
                        setState(() {
                          requestType = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: requestType,
                      title: Text("Online-Meeting",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      value: 'online',
                      onChanged: (val) {
                        setState(() {
                          requestType = val;
                        });
                      },
                    ),
                  ),
                  requestType == "physical"
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            height: 42,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                //border: Border.all(color: Colors.grey[500], width: 1),
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
                            child: TextFormField(
                              //controller: txtName,
                              controller: txtOnlineLink,
                              // validator: (exp) {
                              //   if (exp.length == 0) {
                              //     return 'Please enter your experience';
                              //   }
                              //   return null;
                              // },
                              keyboardType: TextInputType.text,

                              style: TextStyle(fontSize: 15),
                              cursorColor: appPrimaryMaterialColor,

                              decoration: InputDecoration(
                                errorStyle: TextStyle(height: 0),
                                counterText: "",
                                hintText: "Enter Zoom Link or Google Meet Link",
                                contentPadding: const EdgeInsets.all(15),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: isSendLoading == true
              ? LoadingBlueComponent()
              : Text(
                  "Ok",
                  style:
                      TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
                ),
          onPressed: () async {
            global.membercount += 1;
            _sendRequest();
            updateCount();
            Navigator.pop(context);

            // await prefs.clear();
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/LoginScreen', (route) => false);
          },
        ),
      ],
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
          "requestSender": "${prefs.getString(Session.CustomerId)}",
          "requestReceiver": "${widget.directoryData["_id"]}",
          "requestStatus": "requested",
          "notificationData": {
            'notificationBody': "Hi " +
                "${widget.directoryData["name"]}" +
                ", " +
                "${prefs.getString(Session.CustomerName)} wants ${requestType} 1-2-1 meeting with you.",
            'notificationTitle': "TND Request",
          },
          "meetingType": requestType,
          "meetingLink": txtOnlineLink.text
        };
        Services.postForSave(
                apiname: 'users/oneTwoOneConnectionReq_V1', body: body)
            .then((response) async {
          if (response.IsSuccess == true && response.Data == "1") {
            setState(() {
              isSendLoading = false;
            });
            Fluttertoast.showToast(msg: response.Message);
            Navigator.pop(context);
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
// _sendRequest() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       setState(() {
//         isSendLoading = true;
//       });
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var body = {
//         "requestSender": "${prefs.getString(Session.CustomerId)}",
//         "requestReceiver": "${widget.directoryData["_id"]}",
//         "requestStatus": "requested",
//         "notificationData": {
//           'notificationBody': "Hi " +
//               "${widget.directoryData["name"]}" +
//               ", " +
//               "${prefs.getString(Session.CustomerName)} wants 1-2-1 meeting with you.",
//           'notificationTitle': "TND Request",
//         },
//         "meetingType": requestType,
//         "meetingLink": txtOnlineLink.text
//       };
//       // print(body.fields);
//       Services.PostForList(
//               api_name: 'users/oneTwoOneConnectionReq', body: body)
//           .then((subCatResponseList) async {
//         setState(() {
//           isSendLoading = false;
//         });
//         if (subCatResponseList.length > 0) {
//           Fluttertoast.showToast(msg: "Request Send Successfully!");
//         } else {
//           Fluttertoast.showToast(msg: "Try Again!");
//           //show "data not found" in dialog
//         }
//       }, onError: (e) {
//         setState(() {
//           isSendLoading = false;
//         });
//         print("error on call -> ${e.message}");
//         Fluttertoast.showToast(msg: "Something Went Wrong");
//       });
//     }
//   } on SocketException catch (_) {
//     Fluttertoast.showToast(msg: "No Internet Connection.");
//   }
// }
}

class AlertComplete extends StatefulWidget {
  var directoryData;

  AlertComplete({this.directoryData});

  @override
  _AlertCompleteState createState() => _AlertCompleteState();
}

class _AlertCompleteState extends State<AlertComplete> {
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
    return AlertDialog(
      title: new Text(
        "Complete 1-2-1 Request",
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
      content: SingleChildScrollView(
        child: new Wrap(
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
                                  fontSize: 15,
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
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0))),
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
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Topic : ",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtTopic,
                        // validator: (exp) {
                        //   if (exp.length == 0) {
                        //     return 'Please enter your experience';
                        //   }
                        //   return null;
                        // },
                        keyboardType: TextInputType.text,

                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          counterText: "",
                          contentPadding: const EdgeInsets.all(8),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15),
                    child: Text("Generate Reference : ",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
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
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: isLoading == true
              ? LoadingBlueComponent()
              : Text(
                  "Ok",
                  style:
                      TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
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
      ],
    );
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
