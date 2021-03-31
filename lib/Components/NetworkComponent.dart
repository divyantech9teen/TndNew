import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Screens/NetworkingProfile.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkComponent extends StatefulWidget {
  var networkData;
  NetworkComponent({this.networkData});
  @override
  _NetworkComponentState createState() => _NetworkComponentState();
}

class _NetworkComponentState extends State<NetworkComponent> {
  String whatsapp;

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

  /* launchSocialMediaUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new NetworkingProfile(
                      directoryData: widget.networkData,
                    )));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, bottom: 22, left: 12, right: 12),
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width * 1,
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
                width: MediaQuery.of(context).size.width * 0.4,
                height: 210,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey[100]),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${widget.networkData["img"]}",
                        height: 100,
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
                        "${widget.networkData["name"]}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: widget.networkData["business_category"] ==
                                      null
                                  ? Text("")
                                  : Text(
                                      "${widget.networkData["business_category"]["categoryName"]}",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontStyle: FontStyle.italic,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                            ),
                          ),
                          /*  Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              "${widget.networkData["requestStatus"]}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),*/
                        ],
                      ),
                      /* FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: appPrimaryMaterialColor[100],
                                  width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // launchSocialMediaUrl(widget.networkData[]);
                              },
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/videocall.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3),
                                    child: Text(
                                      "Open Zoom Meeting",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),*/
                      /* FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
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
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchwhatsapp(
                                    phone:
                                        "+91" + widget.networkData["whatsApp"],
                                    message: "");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[200], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[600]
                                                .withOpacity(0.2),
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(3.0, 5.0))
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3, top: 3, bottom: 3),
                                    child: Image.asset('assets/whats.png'),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL(widget.networkData["email"], '', '');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Container(
                                  height: 30,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey[300], width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4, top: 5, bottom: 5),
                                    child: Image.asset('assets/gmail.png'),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                launch(
                                    ('tel:// ${widget.networkData["mobile"]}'));
                              },
                              child: Container(
                                height: 30,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey[300], width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
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
                                      left: 4.0, right: 4, top: 4, bottom: 4),
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
