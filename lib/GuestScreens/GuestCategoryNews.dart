import 'dart:developer';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/GuestComponent/GuestCategoryNewsComponent.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';

class GuestCategoryNews extends StatefulWidget {
  var title;

  GuestCategoryNews({this.title});

  @override
  _GuestCategoryNewsState createState() => _GuestCategoryNewsState();
}

class _GuestCategoryNewsState extends State<GuestCategoryNews> {
  List subCatNews = [];
  List subCatBanner = [];
  bool isLoadingCat = true;
  bool isLoadingCatNews = true;

  @override
  void initState() {
    print("++++++++++++++${widget.title}");
    _bannerName();
  }

  _bannerName() async {
    String name;
    name = "${widget.title}";
    _newsBanner(name);
    _newsCategory(name);
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
              "${widget.title}",
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
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        //color: Colors.grey[100],
                        border: Border.all(color: Colors.grey[200], width: 2),
                      ),
                      child: Carousel(
                        boxFit: BoxFit.contain,
                        autoplay: true,
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1500),
                        dotSize: 0.0,
                        //  borderRadius: true,
                        dotIncreasedColor: Color(0xFF9f782d),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
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
                        images: subCatBanner.map((link) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsBannerDetail(
                                      newsData: link,
                                    ),
                                  ));
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                    // borderRadius: BorderRadius.circular(8.0),
                                    child: link['featured_img_src'] == null
                                        ? Center(
                                            child: Image.asset(
                                                'assets/appLogo.png'))
                                        : Image.network(
                                            link['featured_img_src'],
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // height: 220,
                                            fit: BoxFit.fill,
                                          )),
                                Positioned(
                                    bottom: 0.0,
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      decoration: BoxDecoration(
                                        color: Color(0xff4B4B4B4A),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            link["title"],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                letterSpacing: 0.1),
                                          ),
                                          SizedBox(
                                            height: 5,
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
                      padding:
                          const EdgeInsets.only(top: 15.0, bottom: 10, left: 5),
                      child: Text(
                        " ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: appPrimaryMaterialColor),
                      ),
                    ),
                    isLoadingCatNews == true
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: LoadingBlueComponent(),
                          ))
                        : subCatNews.length <= 0
                            ? Center(child: Text("No Data Found"))
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // scrollDirection: Axis.vertical,
                                itemCount: subCatNews.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GuestCategoryNewsComponent(
                                    newsData: subCatNews[index],
                                  );
                                })
                  ],
                ),
              ),
            ),
    );
  }

  _newsBanner(var subcatName) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoadingCat = true;
        });

        FormData body = FormData.fromMap({"news_category": "${subcatName}"});
        Services.PostForList1(api_name: 'custom/slider_news', body: body).then(
            (subCatResponseList) async {
          setState(() {
            isLoadingCat = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              subCatBanner = subCatResponseList;

              //set "data" here to your variable
            });
            log("News Banners ${subCatBanner}");
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
              subCatBanner = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
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
          isLoadingCatNews = true;
        });
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body =
            FormData.fromMap({"news_category": "${subcatId}", "user_id": ""});

        // print(body.fields);
        Services.PostForList1(api_name: 'custom/category_wise_news', body: body)
            .then((subCatResponseList) async {
          setState(() {
            isLoadingCatNews = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              subCatNews = subCatResponseList;

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
              subCatNews = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoadingCatNews = false;
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
