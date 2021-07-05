import 'dart:developer';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/DigitalComponent/LoadinComponent.dart';

import 'OfferPageDetails.dart';

class subcategory extends StatefulWidget {
  String Mid;

  subcategory({this.Mid});
  @override
  _subcategoryState createState() => _subcategoryState();
}

class _subcategoryState extends State<subcategory> {
  bool isOfferLoading = false;
  bool isLoading = true;
  List offerList = [];
  List searchresult = [];
  final TextEditingController _controller = new TextEditingController();

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
        child: isOfferLoading
            ? LoadinComponent()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    crousalContainer(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: _controller,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
                        /* validator: (phone) {
                          Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                          RegExp regExp = new RegExp(pattern);
                          if (phone.length == 0) {
                            return 'Please enter mobile number';
                          } else if (!regExp.hasMatch(phone)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },*/
                        onChanged: searchOperation,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.only(
                              top: 1.0, bottom: 1, left: 10, right: 1),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500),
                          suffixIcon: InkWell(
                            onTap: () {
                              print("hello");
                              _controller.clear();
                              searchOperation('');
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15, left: 15, right: 25),
                                child: Image.asset("assets/search.png"),
                              ),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: appPrimaryMaterialColor[400]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: appPrimaryMaterialColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
    return searchresult.length > 0
        ? GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 0.0, mainAxisSpacing: 0.0),
            itemCount: searchresult.length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferPageDetails(
                                  //  image: offerList[index]["categoryImage"],
                                  Sid: searchresult[index]["_id"].toString(),
                                  Mid: widget.Mid,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey[700], width: 0.2)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /* offerList[index]["categoryIcon"] == ""
                          ?*/
                          Image.asset(
                            "assets/appLogo.png",
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                          ),
                          /* :
                      Image.network(
                        offerList[index]["categoryIcon"],
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                      ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Center(
                              child: Text(
                                "${searchresult[index]["CategoryName"]}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 0.0, mainAxisSpacing: 0.0),
            itemCount: offerList[0].length,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferPageDetails(
                                  //  image: offerList[index]["categoryImage"],
                                  Sid: offerList[0][index]["_id"].toString(),
                                  Mid: widget.Mid,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey[700], width: 0.2)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /* offerList[index]["categoryIcon"] == ""
                          ?*/
                          Image.asset(
                            "assets/appLogo.png",
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                          ),
                          /* :
                      Image.network(
                        offerList[index]["categoryIcon"],
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                      ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            child: Center(
                              child: Text(
                                "${offerList[0][index]["CategoryName"]}",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
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

  void searchOperation(String searchText) {
    print("hello");
    searchresult.clear();
    if (searchText != "") {
      for (int i = 0; i < offerList[0].length; i++) {
        String data1 = offerList[0][i]["CategoryName"];
        if (offerList[0][i]["CategoryName"]
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          setState(() {
            searchresult.add(offerList[0][i]);
          });
        }
      }
      print(searchresult);
    }
  }

  _offer() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isOfferLoading = true;
        });
        var body = {"MastercategoryId": widget.Mid};
        print(body);
        Services.PostForList(api_name: 'admin/getMasterSubcategory', body: body)
            .then((tabResponseList) async {
          setState(() {
            isOfferLoading = false;
          });
          if (tabResponseList.length > 0) {
            setState(() {
              offerList = tabResponseList;
              print(offerList[0]);
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
