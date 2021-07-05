import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Common/Constants.dart';
import '../Common/Services.dart';

class PermissionNoti extends StatefulWidget {
  @override
  _PermissionNotiState createState() => _PermissionNotiState();
}

class _PermissionNotiState extends State<PermissionNoti> {
  List subCategoriesTab = [];
  List<bool> swichbtn = [];
  List subCatNews = [];
  List subCatBanner = [];
  bool isLoadingCat = true;
  List searchlist = new List();
  bool _isSearching = false, isfirst = false;
  bool _permission = true;
  List truandfalse = [];
  List getnotifivationdata = [];
  @override
  void initState() {
    _newsCatTab();
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
              "Notification Permission",
              style: TextStyle(
                color: appPrimaryMaterialColor,
                fontSize: 18,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.separated(
            itemCount: subCategoriesTab.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${subCategoriesTab[index]["newsType"]}",
                      style: TextStyle(fontSize: 18),
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.blue,
                      value: swichbtn[index],
                      onChanged: (bool value) {
                        setState(() {
                          if (swichbtn[index] == true) {
                            getnotifivationdata.remove(
                                subCategoriesTab[index]["newsType"].toString());
                            print("heloooooooooooooooooooooo");
                            print(getnotifivationdata);
                            AddFavoriteNotification();
                            swichbtn[index] = false;
                          } else {
                            setState(() {
                              getnotifivationdata.add(subCategoriesTab[index]
                                      ["newsType"]
                                  .toString());
                              AddFavoriteNotification();
                            });

                            swichbtn[index] = true;
                          }
                          swichbtn[index] = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ));
  }

  _newsCatTab() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.PostForList(api_name: 'admin/getNewsCategory').then(
            (tabResponseList) async {
          setState(() {
            isLoadingCat = false;
          });
          if (tabResponseList.length > 0) {
            setState(() {
              subCategoriesTab = tabResponseList;
              print(subCategoriesTab);
              //  swichbtn.add(false);
              //set "data" here to your variable
              getAllNotificationCat();
            });
            for (int i = 0; i < tabResponseList.length; i++) {
              swichbtn.add(false);
            }
          } else {
            setState(() {
              isLoadingCat = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
          }
        }, onError: (e) {
          setState(() {
            isLoadingCat = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  getAllNotificationCat() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {"userId": prefs.getString(Session.CustomerId)};
        Services.PostForList(
                api_name: 'admin/getAllNotificationCat', body: body)
            .then((tabResponseList) async {
          setState(() {
            isLoadingCat = false;
          });
          if (tabResponseList.length > 0) {
            setState(() {
              print(tabResponseList);
              getnotifivationdata =
                  tabResponseList[0]["favoraitenewsnotification"];
              datacheck();
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isLoadingCat = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
          }
        }, onError: (e) {
          setState(() {
            isLoadingCat = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  datacheck() {
    print("under in the data chek");
    for (int i = 0; i < getnotifivationdata.length; i++) {
      for (int j = 0; j < subCategoriesTab.length; j++) {
        print(getnotifivationdata[i]);
        print(subCategoriesTab[i]["newsType"]);
        if (getnotifivationdata[i] == subCategoriesTab[j]["newsType"]) {
          setState(() {
            print("truuuuuuuuuuuuuuuuuuuu");
            swichbtn[j] = true;
          });
        }
        if (swichbtn[j] != true) {
          swichbtn[j] = false;
        }
      }
    }
    print(swichbtn);
  }

  AddFavoriteNotification() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "userId": prefs.getString(
            Session.CustomerId,
          ),
          "favList": getnotifivationdata,
        };
        Services.PostForList(
                api_name: 'admin/AddFavoriteNotification', body: body)
            .then((tabResponseList) async {
          setState(() {
            isLoadingCat = false;
          });
          if (tabResponseList.length > 0) {
            setState(() {
              print("heloooooo");
            });
          } else {
            setState(() {
              isLoadingCat = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
          }
        }, onError: (e) {
          setState(() {
            isLoadingCat = false;
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
