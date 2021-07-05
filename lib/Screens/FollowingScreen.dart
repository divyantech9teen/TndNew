import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/FollowingComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  List subCategoriesTab = [];
  List subCatNews = [];
  List subCatBanner = [];
  bool isLoadingCat = true;
  List searchlist = new List();
  bool _isSearching = false, isfirst = false;

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
        backgroundColor: Colors.white,
        // elevation: 0,
        title: FittedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: Text(
              "Following",
              style: TextStyle(
                  color: appPrimaryMaterialColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: isLoadingCat == true
          ? LoadingBlueComponent()
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                    child: Container(
                      height: 45,
                      color: Colors.grey[100],
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
                          hintText: "Search Following...",
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500),
                          enabledBorder: OutlineInputBorder(
                            // borderRadius:
                            //     BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            // borderRadius:
                            //     BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: subCategoriesTab.length > 0 &&
                            subCategoriesTab != null
                        ? searchlist.length != 0
                            ? GridView.builder(
                                itemCount: searchlist.length,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 3.0,
                                        left: 3.0,
                                        right: 3.0,
                                        top: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new FollowingComponent(
                                                          title:
                                                              searchlist[index]
                                                                  ["newsType"],
                                                        )));
                                        // Navigator.pushNamed(
                                        //     context, '/GuestCategoryNews');
                                      },
                                      child: Stack(children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ClipRRect(
                                              // borderRadius: BorderRadius.circular(8.0),
                                              child: searchlist[index]
                                                          ['categoryImage'] ==
                                                      null
                                                  ? Container(
                                                      color:
                                                          appPrimaryMaterialColor[
                                                              400],
                                                    )
                                                  : Image.network(
                                                      searchlist[index]
                                                          ['categoryImage'],
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      fit: BoxFit.fill,
                                                    )),
                                        ),
                                        Positioned(
                                            //top: 10,
                                            child: Container(
                                          color:
                                              Colors.black12.withOpacity(0.4),
                                          //  height: 30,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              searchlist[index]["newsType"],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ))
                                      ]),
                                    ),
                                  );
                                })
                            : _isSearching && isfirst
                                ? GridView.builder(
                                    itemCount: searchlist.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 3.0,
                                            left: 3.0,
                                            right: 3.0,
                                            top: 3),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, '/GuestCategoryNews');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new FollowingComponent(
                                                          title:
                                                              searchlist[index]
                                                                  ["newsType"],
                                                        )));
                                          },
                                          child: Stack(children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ClipRRect(
                                                  // borderRadius: BorderRadius.circular(8.0),
                                                  child: searchlist[index][
                                                              'categoryImage'] ==
                                                          null
                                                      ? Container(
                                                          color:
                                                              appPrimaryMaterialColor[
                                                                  400],
                                                        )
                                                      : Image.network(
                                                          searchlist[index]
                                                              ['categoryImage'],
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          fit: BoxFit.fill,
                                                        )),
                                            ),
                                            Positioned(
                                                //top: 10,
                                                child: Container(
                                              color: Colors.black12
                                                  .withOpacity(0.4),
                                              //  height: 30,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  searchlist[index]["newsType"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ))
                                          ]),
                                        ),
                                      );
                                    })
                                : GridView.builder(
                                    itemCount: subCategoriesTab.length,
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 3.0,
                                            left: 3.0,
                                            right: 3.0,
                                            top: 3),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigator.pushNamed(
                                            //     context, '/GuestCategoryNews');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new FollowingComponent(
                                                          title:
                                                              subCategoriesTab[
                                                                      index]
                                                                  ["newsType"],
                                                        )));
                                          },
                                          child: Stack(children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ClipRRect(
                                                  // borderRadius: BorderRadius.circular(8.0),
                                                  child: subCategoriesTab[index]
                                                              [
                                                              'categoryImage'] ==
                                                          null
                                                      ? Container(
                                                          color:
                                                              appPrimaryMaterialColor[
                                                                  400],
                                                        )
                                                      : Image.network(
                                                          subCategoriesTab[
                                                                  index]
                                                              ['categoryImage'],
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                          fit: BoxFit.fill,
                                                        )),
                                            ),
                                            Positioned(
                                                //top: 10,
                                                child: Container(
                                              color: Colors.black12
                                                  .withOpacity(0.4),
                                              //  height: 30,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  subCategoriesTab[index]
                                                      ["newsType"],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ))
                                          ]),
                                        ),
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
                ],
              ),
            ),
    );
  }

  void searchOperation(String searchText) {
    log('===========0================');
    searchlist.clear();
    if (_isSearching != null) {
      isfirst = true;
      log('===========1================');
      print(subCategoriesTab[0]["newsType"]);
      for (int i = 0; i < subCategoriesTab.length; i++) {
        print(subCategoriesTab.length);
        // String headline = subCategoriesTab[i]["title"].toString();

        String newstype = subCategoriesTab[i]["newsType"].toString();
        log('===========2================');
        if (newstype.toLowerCase().contains(searchText.toLowerCase())) {
          searchlist.add(subCategoriesTab[i]);
          log('===========3================');
        }
      }
    }
    setState(() {});
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
}
