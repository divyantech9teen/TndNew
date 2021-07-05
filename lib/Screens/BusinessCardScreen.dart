import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/BusinessCardComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class BusinessCardScreen extends StatefulWidget {
  @override
  _BusinessCardScreenState createState() => _BusinessCardScreenState();
}

class _BusinessCardScreenState extends State<BusinessCardScreen> {
  List businessList = [];
  bool isLoading = true;
  List searchlist = new List();
  bool _isSearching = false, isfirst = false;

  @override
  void initState() {
    _getBusiness();
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
              "Business Card",
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
          actions: [
            /* Padding(
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
            )*/
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35, top: 25),
              child: Container(
                height: 35,
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
                        top: 0.0, bottom: 0, left: 15, right: 5),
                    hintText: "Type to Search...",
                    hintStyle: TextStyle(
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: isLoading == true
                    ? Center(child: LoadingBlueComponent())
                    : businessList.length > 0 && businessList != null
                        ? searchlist.length != 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                // scrollDirection: Axis.horizontal,
                                itemCount: searchlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return BusinessCardComponent(
                                    businessData: searchlist[index],
                                  );
                                })
                            : _isSearching && isfirst
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    // scrollDirection: Axis.horizontal,
                                    itemCount: searchlist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return BusinessCardComponent(
                                        businessData: searchlist[index],
                                      );
                                    })
                                : ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    // scrollDirection: Axis.horizontal,
                                    itemCount: businessList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return BusinessCardComponent(
                                        businessData: businessList[index],
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
                                      color: appPrimaryMaterialColor)),
                            ),
                          ),
              ),
            ),
          ],
        ));
  }

  _getBusiness() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {"id": prefs.getString(Session.CustomerId)};
        log(prefs.getString(Session.CustomerId));
        Services.PostForList(api_name: 'directory/profile', body: body).then(
            (subCatResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              businessList = subCatResponseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              businessList = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
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

  void searchOperation(String searchText) {
    log('===========0================');
    searchlist.clear();
    if (_isSearching != null) {
      isfirst = true;
      log('===========1================');
      print(businessList[1]["name"]);
      for (int i = 0; i < businessList.length; i++) {
        print(businessList.length);
        String name = businessList[i]["name"].toString();

        String cmpName = businessList[i]["company_name"].toString();
        log('===========2================');
        if (name.toLowerCase().contains(searchText.toLowerCase()) ||
            cmpName.toLowerCase().contains(searchText.toLowerCase())) {
          searchlist.add(businessList[i]);
          log('===========3================');
        }
      }
    }
    setState(() {});
  }
}
