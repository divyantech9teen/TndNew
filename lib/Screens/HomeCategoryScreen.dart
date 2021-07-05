import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/CategoryComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class HomeCategoryScreen extends StatefulWidget {
  @override
  _HomeCategoryScreenState createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  List CategoryList = [];
  bool isLoading = true;
  List searchlist = new List();
  bool _isSearching = false, isfirst = false;

  @override
  void initState() {
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Category",
              style: TextStyle(
                color: appPrimaryMaterialColor,
                fontSize: 18,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
          actions: [
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/scan.png'),
                ),
              ),
            )
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
                  onChanged: searchOperation,
                  cursorColor: appPrimaryMaterialColor,
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
                padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                child: isLoading
                    ? Center(child: LoadingBlueComponent())
                    : CategoryList.length > 0 && CategoryList != null
                        ? searchlist.length != 0
                            ? GridView.builder(
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
//                        //widthScreen / heightScreen,
                                        crossAxisSpacing: 20.0,
                                        mainAxisSpacing: 25.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return CategoryComponent(
                                    CatData: searchlist[index],
                                  );
                                },
                                itemCount: searchlist.length,
                              )
                            : _isSearching && isfirst
                                ? GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1,
//                        //widthScreen / heightScreen,
                                            crossAxisSpacing: 20.0,
                                            mainAxisSpacing: 25.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CategoryComponent(
                                        CatData: searchlist[index],
                                      );
                                    },
                                    itemCount: searchlist.length,
                                  )
                                : GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1,
//                        //widthScreen / heightScreen,
                                            crossAxisSpacing: 20.0,
                                            mainAxisSpacing: 25.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CategoryComponent(
                                        CatData: CategoryList[index],
                                      );
                                    },
                                    itemCount: CategoryList.length,
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
                          ),
              ),
            ),
          ],
        ));
  }

  _getCategory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        var body = {};
        Services.PostForList(
          api_name: 'admin/businessCategory',
        ).then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              CategoryList = ResponseList;
            });
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

  void searchOperation(String searchText) {
    log('===========0================');
    searchlist.clear();
    if (_isSearching != null) {
      isfirst = true;
      log('===========1================');
      print(CategoryList[1]["name"]);
      for (int i = 0; i < CategoryList.length; i++) {
        print(CategoryList.length);
        String name = CategoryList[i]["categoryName"].toString();

//        String cmpName = CategoryList[i]["company_name"].toString();
        log('===========2================');
        if (name.toLowerCase().contains(searchText.toLowerCase())
//            ||
//            cmpName.toLowerCase().contains(searchText.toLowerCase())
            ) {
          searchlist.add(CategoryList[i]);
          log('===========3================');
        }
      }
    }
    setState(() {});
  }
}
