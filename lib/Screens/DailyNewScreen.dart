import 'dart:developer';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/DailyNewsComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';

class DailyNewScreen extends StatefulWidget {
  @override
  _DailyNewScreenState createState() => _DailyNewScreenState();
}

class _DailyNewScreenState extends State<DailyNewScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  TabController tabController;
  List subCategoriesTab = [];
  List subCategoriesList = [];
  List imgList = [];
  bool isLoadingCat = true;
  bool isbannerLoading = true;
  bool isLoadingNews = false;
  List searchlist = new List();
  bool _isSearching = false, isfirst = false;

  @override
  void initState() {
    super.initState();
    _newsCatTab();
//    _tabController = TabController(
//      vsync: this,
//      length: 5,
//      initialIndex: 0,
//    );
  }

  _tabCon() {
    _tabController = TabController(
      vsync: this,
      length: subCategoriesTab.length,
    );
    _tabController.addListener(() {
      _newsCategory(subCategoriesTab[_tabController.index]["newsType"]);
      _newsBanner(subCategoriesTab[_tabController.index]["newsType"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: FittedBox(
          child: Row(
            children: [
              Text(
                "The",
                style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Text(
                  "National",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Dawn",
                style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
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
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: isLoadingCat
          ? LoadingBlueComponent()
          : subCategoriesList.length < 0 && subCategoriesList == null
              ? Center(
                  child: Container(
                    //color: Color.fromRGBO(0, 0, 0, 0.6),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("No Data Available",
                        style: TextStyle(
                            fontSize: 20, color: appPrimaryMaterialColor)),
                  ),
                )
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.0,
                            child: TabBar(
                              isScrollable: true,
                              controller: _tabController,
                              unselectedLabelColor: Colors.black,
                              labelColor: appPrimaryMaterialColor,
                              indicatorColor: appPrimaryMaterialColor,
                              onTap: (index) {
                                _newsCategory(
                                    subCategoriesTab[index]["newsType"]);
                              },
                              tabs: List<Widget>.generate(
                                  subCategoriesTab.length, (int index) {
                                return Tab(
                                  child: Text(
                                    subCategoriesTab[index]["newsType"],
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35.0, right: 35, top: 25),
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
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w500),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                            child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              controller: _tabController,
                              children: List<Widget>.generate(
                                  subCategoriesTab.length, (int index) {
                                return isLoadingNews
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                appPrimaryMaterialColor),
                                      ))
                                    : SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 18.0, left: 15, right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0, top: 3),
                                                child: Text(
                                                  "Featured",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                height: 190,
                                                decoration: BoxDecoration(
                                                  //color: Colors.grey[100],
                                                  border: Border.all(
                                                      color: Colors.grey[200],
                                                      width: 2),
//                                                borderRadius: BorderRadius.all(
//                                                    Radius.circular(10.0)),
                                                ),
                                                child: Carousel(
                                                  boxFit: BoxFit.contain,
                                                  autoplay: true,
                                                  animationCurve:
                                                      Curves.fastOutSlowIn,
                                                  animationDuration: Duration(
                                                      milliseconds: 1500),
                                                  dotSize: 0.0,
                                                  //  borderRadius: true,
                                                  dotIncreasedColor:
                                                      Color(0xFF9f782d),
                                                  dotBgColor:
                                                      Colors.transparent,
                                                  dotPosition:
                                                      DotPosition.bottomCenter,
                                                  dotVerticalPadding: 10.0,
                                                  showIndicator: false,
                                                  indicatorBgPadding: 7.0,
                                                  dotColor: Colors.grey,
                                                  onImageChange: (a, b) {
//                                                    log(a.toString());
//                                                    log(b.toString());
                                                    setState(() {
                                                      //skip = b;
                                                    });
                                                  },
                                                  images: imgList.map((link) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NewsBannerDetail(
                                                                newsData: link,
                                                              ),
                                                            ));
                                                      },
                                                      child: Stack(
                                                        children: [
                                                          // FadeInImage
                                                          //     .assetNetwork(
                                                          //   placeholder:
                                                          //       'assets/TND Logo_PNG_Newspaper.png',
                                                          //   image: link[
                                                          //       "featured_img_src"],
                                                          //   // width: 300,
                                                          // ),
                                                          ClipRRect(
                                                              // borderRadius: BorderRadius.circular(8.0),
                                                              child: link['featured_img_src'] ==
                                                                      null
                                                                  ? Image.asset(
                                                                      'assets/appLogo.png')
                                                                  : Image
                                                                      .network(
                                                                      link[
                                                                          'featured_img_src'],
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height:
                                                                          220,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    )),
                                                          Positioned(
                                                              bottom: 0.0,
                                                              child: Container(
                                                                height: 60,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    30,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xff4B4B4B4A),
                                                                  //color: Colors.transparent,
//                                                              borderRadius:
//                                                              BorderRadius.only(
//                                                                  bottomLeft: Radius
//                                                                      .circular(
//                                                                      18.0),
//                                                                  bottomRight: Radius
//                                                                      .circular(
//                                                                      18.0)),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      link[
                                                                          "title"],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              11,
                                                                          letterSpacing:
                                                                              0.1),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                          Icons
                                                                              .timer,
                                                                          size:
                                                                              14,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        link["newsDate"] ==
                                                                                null
                                                                            ? SizedBox()
                                                                            : Text(
                                                                                "${link["newsDate"]}" + "${link["newsTime"]}",
                                                                                style: TextStyle(color: Colors.white, letterSpacing: 0.5, fontSize: 8),
                                                                              )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0, top: 25),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Popular News",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.black,
                                                      size: 23,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              isLoadingCat
                                                  ? Center(
                                                      child:
                                                          LoadingBlueComponent())
                                                  : subCategoriesList.length >
                                                              0 &&
                                                          subCategoriesList !=
                                                              null
                                                      ? searchlist.length != 0
                                                          ? ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              // scrollDirection: Axis.horizontal,
                                                              itemCount:
                                                                  searchlist
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int
                                                                          index) {
                                                                return DailyNewsComponent(
                                                                  newsData:
                                                                      searchlist[
                                                                          index],
                                                                  newsType: subCategoriesTab[
                                                                          index]
                                                                      [
                                                                      "newsType"],
                                                                  isBookmark: searchlist[
                                                                          index]
                                                                      [
                                                                      "bookmark"],
                                                                );
                                                              })
                                                          : _isSearching &&
                                                                  isfirst
                                                              ? ListView
                                                                  .builder(
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      // scrollDirection: Axis.horizontal,
                                                                      itemCount:
                                                                          searchlist
                                                                              .length,
                                                                      itemBuilder: (BuildContext
                                                                              context,
                                                                          int
                                                                              index) {
                                                                        return DailyNewsComponent(
                                                                          newsData:
                                                                              searchlist[index],
                                                                          isBookmark:
                                                                              searchlist[index]["bookmark"],
                                                                        );
                                                                      })
                                                              : ListView
                                                                  .builder(
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      // scrollDirection: Axis.horizontal,
                                                                      itemCount:
                                                                          subCategoriesList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return DailyNewsComponent(
                                                                          newsData:
                                                                              subCategoriesList[index],
                                                                          isBookmark:
                                                                              subCategoriesList[index]["bookmark"],
                                                                        );
                                                                      })
                                                      : Center(
                                                          child: Container(
                                                            //color: Color.fromRGBO(0, 0, 0, 0.6),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            child: Text(
                                                                "No Data Available",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color:
                                                                        appPrimaryMaterialColor)),
                                                          ),
                                                        )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
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

            _newsCategory(tabResponseList[0]["newsType"]);
            _newsBanner(tabResponseList[0]["newsType"]);
            print("===================");
            print(tabResponseList[0]["_id"]);
            _tabCon();
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

  _newsCategory(var subcatId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoadingNews = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "news_category": "${subcatId}",
          "user_id": "${prefs.getString(Session.CustomerId)}"
        });

        // print(body.fields);
        Services.PostForList1(api_name: 'custom/category_wise_news', body: body)
            .then((subCatResponseList) async {
          setState(() {
            isLoadingNews = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              subCategoriesList = subCatResponseList;

              //set "data" here to your variable
            });
            // for (var i = 0; i <= subCatResponseList.length; i++) {
            //   if (subCatResponseList[i]["trending"] == true) {
            //     setState(() {
            //       imgList.add(subCatResponseList[i]);
            //       tabController =
            //           TabController(length: imgList.length, vsync: this);
            //     });
            //   }
            // }
          } else {
            setState(() {
              subCategoriesList = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoadingNews = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _newsBanner(var subcatName) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isbannerLoading = true;
        });

        FormData body = FormData.fromMap({"news_category": "${subcatName}"});
        Services.PostForList1(api_name: 'custom/slider_news', body: body).then(
            (subCatResponseList) async {
          setState(() {
            isbannerLoading = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              imgList = subCatResponseList;

              //set "data" here to your variable
            });
            log("News Banners ${imgList}");
            // for (var i = 0; i <= subCatResponseList.length; i++) {
            //   //  if (subCatResponseList[i]["trending"] == true) {
            //   setState(() {
            //     imgList.add(subCatResponseList[i]);
            //     tabController =
            //         TabController(length: imgList.length, vsync: this);
            //   });
            // }
            // }
          } else {
            setState(() {
              imgList = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isbannerLoading = false;
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
      print(subCategoriesList[0]["title"]);
      for (int i = 0; i < subCategoriesList.length; i++) {
        print(subCategoriesList.length);
        String headline = subCategoriesList[i]["title"].toString();

        String newstype = subCategoriesList[i]["title"].toString();
        log('===========2================');
        if (headline.toLowerCase().contains(searchText.toLowerCase()) ||
            newstype.toLowerCase().contains(searchText.toLowerCase())) {
          searchlist.add(subCategoriesList[i]);
          log('===========3================');
        }
      }
    }
    setState(() {});
  }
}
