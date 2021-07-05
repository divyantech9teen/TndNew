import 'dart:developer';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Dealbox/subcategory.dart';

import 'OfferPageDetails.dart';

class OfferPage extends StatefulWidget {
  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  bool isOfferLoading = true;
  bool isLoading = true;
  List offerList = [];

  @override
  void initState() {
    _offer();
  }

  List<String> listOfIcons = [
    "assets/z.jpeg",
    "assets/z.jpeg",
    "assets/z.jpeg",
    "assets/z.jpeg",
    "assets/z.jpeg",
    "assets/z.jpeg",
  ];

  List<String> listOfContent = [
    "Monil",
    "Rinki",
    "Chirag",
    "Divyan",
    "Girjesh",
    "Sunny",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Offers",
          style: TextStyle(
            color: appPrimaryMaterialColor,
            fontSize: 18,
            //fontWeight: FontWeight.bold
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              crousalContainer(),
              SizedBox(
                height: 20,
              ),
              gridViewContainer(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  gridViewContainer() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 0.0, mainAxisSpacing: 0.0),
        itemCount: offerList.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => subcategory(
                              //  image: offerList[index]["categoryImage"],
                              Mid: offerList[index]["_id"],
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[700], width: 0.2)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /* offerList[index]["categoryIcon"] == ""
                          ?*/
                      Image.asset(
                        "assets/appLogo.png",
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                      ),
                      /* :
                      Image.network(
                        offerList[index]["categoryIcon"],
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                      ),*/
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "${offerList[index]["CategoryName"]}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ));
  }

  crousalContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Carousel(
        dotPosition: DotPosition.bottomCenter,
        autoplay: true,
        dotColor: Colors.grey[200],
        dotIncreasedColor: Colors.white,
        dotBgColor: Colors.transparent,
        images: [
          new Image.asset(
            'assets/z.jpeg',
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'assets/z.jpeg',
            fit: BoxFit.cover,
          ),
          new Image.asset(
            'assets/z.jpeg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  _offer() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.PostForList(api_name: 'admin/getallMasterCategory').then(
            (tabResponseList) async {
          setState(() {
            isOfferLoading = false;
          });
          if (tabResponseList.length > 0) {
            setState(() {
              offerList = tabResponseList;
              print(offerList);
              //set "data" here to your variable
            });

            log("=============${tabResponseList}");
          } else {
            setState(() {
              isOfferLoading = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
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
}
