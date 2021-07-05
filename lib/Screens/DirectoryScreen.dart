import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/DirectoryComponent.dart';
import 'package:the_national_dawn/Components/GridDirectoryComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Global.dart' as global;

class DirectoryScreen extends StatefulWidget {
  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  List directoryList = [];
  List StatusList = [];
  bool isLoading = true;
  List searchlist = new List();
  List searchlist1 = new List();
  bool isfirst = true;
  bool _isSearching1 = false, isfirst1 = false;
  String dropdownValue;
  bool isOfferLoading = true;
  List offerList = [];
  List<OfferClass> offerCatList = [];
  OfferClass selectedOfferCat;

  @override
  void initState() {
    _getDirectory();
    _getOfferCat();
    // _getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Directory",
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
        // bottomNavigationBar: Container(
        //   height: 50,
        //   color: appPrimaryMaterialColor[800],
        //   child: Center(
        //       child: Text(
        //     "Become Premium Member",
        //     style: TextStyle(
        //         color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        //   )),
        // ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  /*boxShadow: [
                      BoxShadow(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]*/
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 15),
                  cursorColor: appPrimaryMaterialColor,
                  onChanged: searchOperation,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      size: 25,
                      color: Colors.black,
                    ),

//                    Padding(
//                      padding: const EdgeInsets.only(right: 5.0, top: 0),
//                      child: Image.asset("assets/search.png"),
//                    ),
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                        top: 5.0, bottom: 0, left: 15, right: 5),
                    hintText: "Type to Search...",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    //   borderSide: BorderSide(color:appPrimaryMaterialColor[100]),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    //   borderSide: BorderSide(color: appPrimaryMaterialColor[100]),
                    // ),
                  ),
                ),
              ),
            ),
 /*           Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  *//*boxShadow: [
                      BoxShadow(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]*//*
                ),
                child: DropdownButtonHideUnderline(
                  child: isOfferLoading
                      ? LoadingBlueComponent()
                      : DropdownButton<OfferClass>(
                          // hint: Text("select"),
                          // selectedOfferCat == null
                          //                               //     ?
                          // Text(
                          //                                       "Select category",
                          //                                       style: TextStyle(
                          //                                         color: Colors.black,
                          //                                       ),
                          //                                     ),
                          // : Text(selectedOfferCat.offerName),
                          dropdownColor: Colors.white,

                          icon: isfirst == true
                              ? Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                  color: Colors.black,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchlist.clear();
                                      isfirst = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                          isExpanded: true,
                          value: selectedOfferCat,
                          onChanged: (value) {
                            setState(() {
                              selectedOfferCat = value;
                              searchOperation1(selectedOfferCat.offerName);
                            });
                          },
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('Select Categories'),
                          ),
                          items: offerCatList.map(
                            (OfferClass offer) {
                              return DropdownMenuItem<OfferClass>(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    offer.offerName.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                value: offer,
                              );
                            },
                          ).toList(),
                        ),
                ),
              ),
            ),*/
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: isLoading == true
                      ? Center(child: LoadingBlueComponent())
                      : directoryList.length > 0 && directoryList != null
                          ? isfirst && searchlist.length == 0
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: directoryList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DirectoryComponent(
                                      directoryData: directoryList[index],
                                    );
                                  })
                              : searchlist.length != 0
                                  ? ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      // scrollDirection: Axis.horizontal,
                                      itemCount: searchlist.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return DirectoryComponent(
                                          directoryData: searchlist[index],
                                        );
                                      })
                                  : Center(
                                      child: Container(
                                        //color: Color.fromRGBO(0, 0, 0, 0.6),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Text("No Data Available",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color:
                                                    appPrimaryMaterialColor)),
                                      ),
                                    )
                          : Center(
                              child: Container(
                                //color: Color.fromRGBO(0, 0, 0, 0.6),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text("No Data Available",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: appPrimaryMaterialColor)),
                              ),
                            )),
            ),
          ],
        ));
  }

  _getOfferCat() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getState().then((responseList) async {
          setState(() {
            isOfferLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              offerCatList = responseList;
              // selectedOfferCat = responseList[0];
            });
            //_getOffer(selectedOfferCat.offerId);
            // _getOffer(responseList[0].offerId);
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isOfferLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _getDirectory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        print("MY NEW MEMBER COUNT");
        print(global.membercount);
        var body = {"userid": prefs.getString(Session.CustomerId)};
        //print("userid: ${prefs.getString(Session.CustomerId)}");
        Services.PostForList(api_name: 'directory/directorylisting', body: body)
            .then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              directoryList = ResponseList;
            });
            //print(ResponseList);
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

//   _getStatus() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
// //        var body = {};
//         Services.PostForList(
//           api_name: 'directory/directoryconnection',
//         ).then((ResponseList) async {
//           setState(() {
//             isLoading = false;
//           });
//           if (ResponseList.length > 0) {
//             setState(() {
//               StatusList = ResponseList;
//             });
//             print(ResponseList);
//           } else {
//             setState(() {
//               isLoading = false;
//             });
//             Fluttertoast.showToast(msg: "No Data Found");
//             //show "data not found" in dialog
//           }
//         }, onError: (e) {
//           setState(() {
//             isLoading = false;
//           });
//           print("error on call -> ${e.message}");
//           Fluttertoast.showToast(msg: "Something Went Wrong");
//         });
//       }
//     } on SocketException catch (_) {
//       Fluttertoast.showToast(msg: "No Internet Connection.");
//     }
//   }

  void searchOperation(String searchText) {
    /*  log('===========0================');*/
    setState(() {
      searchlist.clear();
      isfirst = false;
    });
    // log('===========1================');
    //print(directoryList[1]["name"]);
    for (int i = 0; i < directoryList.length; i++) {
      //print(directoryList.length);
      String name = directoryList[i]["name"].toString();

      String cmpName = directoryList[i]["business_category"].toString();
      // log('===========2================');
      if (name.toLowerCase().contains(searchText.toLowerCase()) ||
          cmpName.toLowerCase().contains(searchText.toLowerCase())) {
        searchlist.add(directoryList[i]);
        //  log('===========3================');
      }
    }
    setState(() {});
  }

  void searchOperation1(String searchText) {
    // log('===========0================');
    setState(() {
      searchlist.clear();
      isfirst = false;
    });
    // log('===========1================');
    //print(directoryList[1]["name"]);
    for (int i = 0; i < directoryList.length; i++) {
      //print(directoryList.length);
      String name = directoryList[i]["name"].toString();

      String cmpName = directoryList[i]["business_category"].toString();
      //   log('===========2================');
      if (cmpName.toLowerCase().contains(searchText.toLowerCase()))
      // ||
      // cmpName.toLowerCase().contains(searchText.toLowerCase())
      {
        searchlist.add(directoryList[i]);
        // log('===========3================');
      }
    }
  }

  fun() {
    if (isfirst == true) {
      Icon(
        Icons.arrow_drop_down,
        size: 40,
        color: Colors.black,
      );
      isfirst = false;
    } else {
      Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Icon(
          Icons.close,
          size: 35,
          color: Colors.black,
        ),
      );
    }
  }
}
