import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';
import 'GuestBannerScreen.dart';
import 'GuestLatestNews.dart';
import 'GuestProfile.dart';

class GuestHome extends StatefulWidget {
  @override
  _GuestHomeState createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  List newsList = [];
  List extraNewsList = [];
  List newsCatList = [];
  bool isLoading = true;

  @override
  void initState() {
    _LatestNews();
    _ExtraLatestNews();
    _newsCategory();
  }

  @override
  Widget build(BuildContext context) {
    log("====${newsCatList.length}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 0,
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
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: isLoading == true
          ? LoadingBlueComponent()
          : Swiper(
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return GuestBannerScreen(
                    newsData: newsList,
                    extraNewsData: extraNewsList,
                  );
                } else {
                  return GuestLatestNews(
                    newsData: newsCatList[index],
                  );
                }
              },
              autoplay: false,
              loop: false,

              itemHeight: MediaQuery.of(context).size.height,
              containerHeight: MediaQuery.of(context).size.height,
              itemCount: newsCatList.length,
              autoplayDisableOnInteraction: false,

              //viewportFraction: 0.8,

              // scale: 0.9,
              scrollDirection: Axis.vertical,
              pagination: new SwiperPagination(
                builder: new FractionPaginationBuilder(
                    color: Colors.transparent, activeColor: Colors.transparent),
              ),
              control: null,
            ),
    );
  }

  _LatestNews() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap({"news_category": "local-news"});
        Services.PostForList1(api_name: 'custom/slider_news', body: body).then(
            (bannerresponselist) async {
          setState(() {
            isLoading = false;
          });
          if (bannerresponselist.length > 0) {
            setState(() {
              newsList = bannerresponselist;
              //set "data" here to your variable
            });
            //  log("My Data" + imgList.toString());
          } else {
            Fluttertoast.showToast(msg: "Banner Not Found");
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

  _ExtraLatestNews() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap({"news_category": "local-news"});
        Services.PostForList1(api_name: 'custom/extra_slider_news', body: body)
            .then((bannerresponselist) async {
          setState(() {
            isLoading = false;
          });
          if (bannerresponselist.length > 0) {
            setState(() {
              extraNewsList = bannerresponselist;
              //set "data" here to your variable
            });
            //  log("My Data" + imgList.toString());
          } else {
            Fluttertoast.showToast(msg: "Banner Not Found");
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

  _newsCategory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body =
            FormData.fromMap({"news_category": "local-news", "user_id": ""});

        // print(body.fields);
        Services.PostForList1(api_name: 'custom/home_page_news', body: body)
            .then((subCatResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              newsCatList = subCatResponseList;

              //set "data" here to your variable
            });
            print("Home page news");
            //print(newsCatList);
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
              newsCatList = [];
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
}
