import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/BookMarkComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class BookMarkScreen extends StatefulWidget {
  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  List bookmarkList = [];
  bool isLoading = true;

  @override
  void initState() {
    _getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Book Marked",
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
          /* actions: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 18, left: 10, bottom: 8),
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
                child: Image.asset('assets/scan.png'),
              ),
            )
          ],*/
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15, top: 15),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: isLoading == true
                ? LoadingBlueComponent()
                : bookmarkList.length > 0
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        itemCount: bookmarkList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BookMarkComponent(
                            bookmarkData: bookmarkList[index],
                          );
                        })
                    : Center(child: Text("No Data Found...!")),
          ),
        ));
  }

  _getBookmark() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {"userid": prefs.getString(Session.CustomerId)};
        Services.PostForList(
                api_name: 'admin/getsingleuserbookmark', body: body)
            .then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              bookmarkList = ResponseList;
            });
          } else {
            setState(() {
              isLoading = false;
            });
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
