import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';

class FollowingNewsComponent extends StatefulWidget {
  var newsData, isBookmark;

  FollowingNewsComponent({this.newsData, this.isBookmark});

  @override
  _FollowingNewsComponentState createState() => _FollowingNewsComponentState();
}

class _FollowingNewsComponentState extends State<FollowingNewsComponent> {
  String parsedString;
  bool isBookmarkLoading = false;
  bool isBookmark = false;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  // "${widget.newsData["content"]}"

  @override
  void initState() {
    _parseHtmlString("${widget.newsData["content"]}");
    setState(() {
      isBookmark = widget.isBookmark;
    });
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
                builder: (context) => NewsBannerDetail(
                  newsData: widget.newsData,
                ),
              ));
        },
        child: Container(
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, top: 15.0, right: 5),
                      child: Text(
                        "${widget.newsData["title"]}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, right: 5, top: 5),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.7,
                            child: Text(
                              "${parsedString}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  //  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.4),
                            ),
                          ),
                          IconButton(
                              icon: isBookmark == false
                                  ? Icon(
                                      Icons.favorite_border,
                                      size: 22,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      size: 22,
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                _addToBookmark();
                              }),
                          // GestureDetector(
                          //   onTap: () {
                          //     _addToBookmark();
                          //   },
                          //   child: isBookmark == false
                          //       ? Container(
                          //           height: 25,
                          //           child: Icon(
                          //             Icons.favorite_border,
                          //             size: 25,
                          //             color: Colors.red,
                          //           ))
                          //       : Container(
                          //           height: 25,
                          //           child: Icon(
                          //             Icons.favorite,
                          //             size: 25,
                          //             color: Colors.red,
                          //           )),
                          // ),
                        ],
                      ),
                    ),
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     child: Icon(Icons.favorite_border)),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                  height: 300,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          child: widget.newsData['featured_img_src'] == null
                              ? Container(
                                  color: appPrimaryMaterialColor[100],
                                  child: Center(
                                      child: Image.asset(
                                    'assets/appLogo.png',
                                    width: 150,
                                    height: 300,
                                  )),
                                )
                              : Image.network(
                                  widget.newsData['featured_img_src'],
                                  width: 150,
                                  height: 300,

                                  // height: 220,
                                  fit: BoxFit.fill,
                                )),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                            "http://www.thenationaldawn.in/${widget.newsData["slug"]}",
                            // subject: subject,
                            // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              color: Colors.white.withOpacity(0.4),
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.share,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  ))
            ],
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
}
