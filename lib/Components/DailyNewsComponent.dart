import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Screens/PopularNewsScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class DailyNewsComponent extends StatefulWidget {
  var newsData, newsType, isBookmark;
  String instagram, facebook, linkedIn, twitter, whatsapp;

  DailyNewsComponent(
      {this.instagram,
      this.facebook,
      this.linkedIn,
      this.twitter,
      this.whatsapp,
      this.newsData,
      this.newsType,
      this.isBookmark});

  @override
  _DailyNewsComponentState createState() => _DailyNewsComponentState();
}

class _DailyNewsComponentState extends State<DailyNewsComponent> {
  bool isBookmarkLoading = false;
  bool isBookmark = false;

  @override
  void initState() {
    setState(() {
      isBookmark = widget.isBookmark;
    });
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PopularNewsScreen(
                newsData: widget.newsData,
              ),
            ),
          );
        },
        child: Container(
          height: 135,
          decoration: BoxDecoration(
            //color: ColorUtils.buttonDarkBlueColor,
            boxShadow: [
              new BoxShadow(
                color: Colors.white,
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Card(
            elevation: 02.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 10.0, right: 5),
                        child: Text(
                          "${widget.newsData["title"]} ",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 13.0, right: 0),
                      //   child: Container(
                      //     height: 22,
                      //     width: 120,
                      //     decoration: BoxDecoration(
                      //       //color: Color(0xff4B4B4BE6),
                      //       color: Colors.grey[600],
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(14.0)),
                      //     ),
                      //     child: Center(
                      //         child: Text(
                      //       //"${widget.newsData["newsType"]["newsType"]} ",
                      //       "av",
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold),
                      //     )),
                      //   ),
                      // ),
//                                    SizedBox(
//                                      height: 8,
//                                    ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              size: 14,
                              color: Colors.grey,
                            ),
                            Text(
                              "${widget.newsData["newsDate"] + "  " + widget.newsData["newsTime"]}",
                              // "",
                              style: TextStyle(color: Colors.grey, fontSize: 8),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // GestureDetector(
                            //   child: Container(
                            //       height: 25,
                            //       child: Image.asset(
                            //         "assets/whats.png",
                            //         height: 25,
                            //       )),
                            //   onTap: () {
                            //     launchwhatsapp(phone: "", message: "");
                            //   },
                            // ),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            GestureDetector(
                              onTap: () {
                                Share.share(
                                  "http://www.thenationaldawn.in/${widget.newsData["slug"]}",
                                  // subject: subject,
                                  // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                                );
                              },
                              child: Container(
                                  height: 25,
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.black,
                                    size: 25.0,
                                  )

                                  // Image.asset(
                                  //   "assets/shares.png",
                                  //   height: 25,
                                  //   color: appPrimaryMaterialColor,
                                  // ),
                                  ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                _addToBookmark();
                              },
                              child: isBookmark == false
                                  ? Container(
                                      height: 25,
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 25,
                                        color: Colors.red,
                                      ))
                                  : Container(
                                      height: 25,
                                      child: Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: Colors.red,
                                      )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 0.0, bottom: 0, top: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        "${widget.newsData["featured_img_src"]} ",
                        //height: 91,
                        width: 95,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addToBookmark() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "userId": prefs.getString(Session.CustomerId),
          "newsId": "${widget.newsData["id"]}",
        };
        setState(() {
          isBookmarkLoading = true;
        });
        Services.PostForList(api_name: 'admin/addToBookMark', body: body).then(
            (ResponseList) async {
          setState(() {
            isBookmarkLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              // isBookmark = !isBookmark;
              isBookmark = ResponseList[0]["status"];
            });
            if (isBookmark == true) {
              Fluttertoast.showToast(msg: "Added to Bookmark");
            } else {
              Fluttertoast.showToast(msg: "Remove from Bookmark");
            }
          } else {
            setState(() {
              isBookmarkLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isBookmarkLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  // _addToBookmark() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       var body = {
  //         "userId": prefs.getString(Session.CustomerId),
  //         "newsId": "${widget.newsData["id"]}",
  //       };
  //       setState(() {
  //         isBookmarkLoading = true;
  //       });
  //       Services.postForSave(apiname: 'admin/addToBookMark', body: body).then(
  //           (responseList) async {
  //         setState(() {
  //           isBookmarkLoading = false;
  //         });
  //         if (responseList.IsSuccess == true && responseList.Data == "1") {
  //           setState(() {
  //             isBookmark = !isBookmark;
  //           });
  //           if (isBookmark == true) {
  //             Fluttertoast.showToast(msg: "Added to Bookmark");
  //           } else {
  //             Fluttertoast.showToast(msg: "Remove from Bookmark");
  //           }
  //         } else {
  //           Fluttertoast.showToast(msg: "Data Not Found");
  //           //show "data not found" in dialog
  //         }
  //       }, onError: (e) {
  //         setState(() {
  //           isBookmarkLoading = false;
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
