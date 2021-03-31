import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Screens/BookMarkDetailScreen.dart';

class BookMarkComponent extends StatefulWidget {
  var bookmarkData;
  BookMarkComponent({this.bookmarkData});

  @override
  _BookMarkComponentState createState() => _BookMarkComponentState();
}

class _BookMarkComponentState extends State<BookMarkComponent> {
  // String dateData;
  // List<String> date;
  // String month;
  //
  // @override
  // void initState() {
  //   //dateData = " ${widget.notificationData["date"]}";
  //   funDate();
  // }
  //
  // funDate() {
  //   dateData = " ${widget.bookmarkData["newsDate"]}";
  //   log(" ${widget.bookmarkData["newsDate"]}");
  //   date = dateData.split(' ');
  //   print("-------------------->${date}");
  //   funMonth("${date[2]}");
  // }
  //
  // funMonth(String mon) {
  //   if (mon == "01") {
  //     month = "Jan";
  //   } else if (mon == "02") {
  //     month = "Feb";
  //   } else if (mon == "03") {
  //     month = "March";
  //   } else if (mon == "04") {
  //     month = "April";
  //   } else if (mon == "05") {
  //     month = "May";
  //   } else if (mon == "06") {
  //     month = "June";
  //   } else if (mon == "07") {
  //     month = "July";
  //   } else if (mon == "08") {
  //     month = "Aug";
  //   } else if (mon == "09") {
  //     month = "Sept";
  //   } else if (mon == "10") {
  //     month = "Oct";
  //   } else if (mon == "11") {
  //     month = "Nov";
  //   } else if (mon == "12") {
  //     month = "Dec";
  //   } else {
  //     month = "";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new BookMarkDetailScreen(
                        bookmarkData: widget.bookmarkData,
                      )));
        },
        child: Container(
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
                        padding: const EdgeInsets.only(left: 16.0, top: 15.0),
                        child: Text(
                          "${widget.bookmarkData["title"]}",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 13.0),
                      //   child: Container(
                      //     height: 30,
                      //     width: 120,
                      //     decoration: BoxDecoration(
                      //       //color: Color(0xff4B4B4BE6),
                      //       color: Colors.grey[600],
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(14.0)),
                      //     ),
                      //     child: Center(
                      //         child: Text(
                      //       "${widget.bookmarkData["content"]}",
                      //       overflow: TextOverflow.ellipsis,
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold),
                      //     )),
                      //   ),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.timer,
                                size: 16,
                                color: Colors.grey,
                              ),
                              Text(
                                " ${widget.bookmarkData["newsDate"] + "  " + widget.bookmarkData["newsTime"]}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      "${widget.bookmarkData["featured_img_src"]}",
                      height: 100,
                      width: 130,
                      fit: BoxFit.cover,
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
}
