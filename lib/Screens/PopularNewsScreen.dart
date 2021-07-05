import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';

class PopularNewsScreen extends StatefulWidget {
  var newsData;

  PopularNewsScreen({this.newsData});

  @override
  _PopularNewsScreenState createState() => _PopularNewsScreenState();
}

class _PopularNewsScreenState extends State<PopularNewsScreen> {
  bool isLoading = false;
  List bookmarkList = [];
  String CustomerId;
  String parsedString;
  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = prefs.getString(Session.CustomerId);
    });
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  // "${widget.newsData["content"]}"

  @override
  void initState() {
    _profile();
    _parseHtmlString("${widget.newsData["content"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  size: 30.0,
                )),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(
                "http://www.thenationaldawn.in/${widget.newsData["slug"]}",
                // subject: subject,
                // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    Icons.share,
                    color: Colors.black,
                    size: 30.0,
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 2,
            ),
            Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    //   height: 420,
                    width: MediaQuery.of(context).size.width,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/TND Logo_PNG_Newspaper.png",
                      fit: BoxFit.contain,
                      image: "${widget.newsData["featured_img_src"]}",
                    ),
                  ),
                  // Container(
                  //     height: 60,
                  //     color: Colors.white,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 15.0, right: 15),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           // Row(
                  //           //   children: <Widget>[
                  //           //     Container(
                  //           //       height: 24,
                  //           //       width: 70,
                  //           //       decoration: BoxDecoration(
                  //           //         borderRadius:
                  //           //             BorderRadius.all(Radius.circular(12)),
                  //           //         color: Colors.grey[100],
                  //           //       ),
                  //           //       child: Center(
                  //           //           child: Text(
                  //           //         "celebrity",
                  //           //         style: TextStyle(
                  //           //             color: Colors.black, fontSize: 11),
                  //           //       )),
                  //           //     ),
                  //           //     SizedBox(
                  //           //       width: 10,
                  //           //     ),
                  //           //     Container(
                  //           //       height: 24,
                  //           //       width: 65,
                  //           //       decoration: BoxDecoration(
                  //           //         borderRadius:
                  //           //             BorderRadius.all(Radius.circular(12)),
                  //           //         color: Colors.grey[100],
                  //           //       ),
                  //           //       child: Center(
                  //           //           child: Text(
                  //           //         "ronaldo",
                  //           //         style: TextStyle(
                  //           //             color: Colors.black, fontSize: 11),
                  //           //       )),
                  //           //     ),
                  //           //   ],
                  //           // ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Row(
                  //             // crossAxisAlignment: CrossAxisAlignment.start,
                  //             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: <Widget>[
                  //               Icon(
                  //                 Icons.timer,
                  //                 size: 20,
                  //                 color: Colors.grey,
                  //               ),
                  //               Text(
                  //                 "${widget.newsData["newsDate"] + "  " + widget.newsData["newsTime"]}",
                  //                 style: TextStyle(
                  //                     color: Colors.grey, fontSize: 8),
                  //               )
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                  // Positioned(
                  //     top: 8.0,
                  //     left: 8.0,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: Container(
                  //           height: 40,
                  //           width: 40,
                  //           decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               border: Border.all(
                  //                   color: Colors.grey[200], width: 1),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10.0)),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                     color: Colors.grey[600].withOpacity(0.2),
                  //                     blurRadius: 1.0,
                  //                     spreadRadius: 1.0,
                  //                     offset: Offset(3.0, 5.0))
                  //               ]),
                  //           child: Icon(
                  //             Icons.arrow_back_ios_outlined,
                  //             color: Colors.black,
                  //             size: 30.0,
                  //           )),
                  //     )),
                  // Positioned(
                  //     top: 8.0,
                  //     right: 8.0,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         Share.share(
                  //           "http://www.thenationaldawn.in/${widget.newsData["slug"]}",
                  //           // subject: subject,
                  //           // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                  //         );
                  //       },
                  //       child: Container(
                  //           height: 40,
                  //           width: 40,
                  //           decoration: BoxDecoration(
                  //               color: Colors.grey[100],
                  //               border: Border.all(
                  //                   color: Colors.grey[200], width: 1),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10.0)),
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                     color: Colors.grey[600].withOpacity(0.2),
                  //                     blurRadius: 1.0,
                  //                     spreadRadius: 1.0,
                  //                     offset: Offset(3.0, 5.0))
                  //               ]),
                  //           child: Icon(
                  //             Icons.share,
                  //             color: Colors.black,
                  //             size: 30.0,
                  //           )),
                  //     )),
//                   Positioned(
//                       bottom: 30.0,
//                       right: 10.0,
//                       child: GestureDetector(
//                         onTap: () {
//                           // Navigator.push(context,MaterialPageRoute(builder:(context) =>Offers()));
//                         },
//                         child: Container(
//                           height: 74,
//                           width: 74,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                   blurRadius: 2,
//                                   color: Color(0xff16B8FF).withOpacity(0.2),
//                                   spreadRadius: 3,
//                                   offset: Offset(1, 6))
//                             ],
//                           ),
//                           child: widget.newsData["bookmark"] == false
//                               ? CircleAvatar(
//                                   radius: 30.0,
//                                   backgroundColor: Colors.white,
//                                   child: GestureDetector(
//                                     onTap: () {},
//                                     child: Icon(Icons.favorite_border,
//                                         color: Colors.red, size: 45.0),
//                                   )
// //                            Image.asset("assets/Lheart.png"),
//                                   //Icon(Icons.favorite,color: Colors.red,size: 45.0,),
//                                   )
//                               : CircleAvatar(
//                                   radius: 30.0,
//                                   backgroundColor: Colors.white,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       addToBookmark();
//                                     },
//                                     child: Icon(Icons.favorite,
//                                         color: Colors.red, size: 45.0),
//                                   )
// //                            Image.asset("assets/Lheart.png"),
//                                   //Icon(Icons.favorite,color: Colors.red,size: 45.0,),
//                                   ),
//                         ),
//                       )
// //                      child: CircleAvatar(
// //                        radius: 40,
// //                          backgroundColor: Colors.white,
// //                          child: Icon(Icons.favorite,color: Colors.red,size: 45.0,))
//                       ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${widget.newsData["title"]}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${parsedString}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Color(0xff010101),
                            fontSize: 14,
                            letterSpacing: 0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addToBookmark() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {"userId": CustomerId, "newsId": widget.newsData["_id"]};
        print(body);
        Services.PostForList(api_name: 'admin/addToBookMark', body: body).then(
            (ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              bookmarkList = ResponseList;
            });
            Fluttertoast.showToast(msg: "Bookmarked Successfully!");
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No Data Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
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
