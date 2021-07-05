import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/OfferComponent.dart';

class OfferScreen extends StatefulWidget {
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  String dropdownValue;
  bool isOfferLoading = true;
  bool isLoading = true;
  List offerList = [];
  List<OfferClass> offerCatList = [];
  OfferClass selectedOfferCat;

  @override
  void initState() {
    _getOfferCat();
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
              selectedOfferCat = responseList[0];
            });
            //_getOffer(selectedOfferCat.offerId);
            _getOffer(responseList[0].offerId);
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

  _getOffer(var offerId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        var body = {"businessCategory_id": "${offerId}"};
        Services.PostForList(api_name: 'admin/getOfferOfBusiness', body: body)
            .then((subCatResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              offerList = subCatResponseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              offerList = [];
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
              "Offers",
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
        body: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15, top: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 15),
                child: Container(
                    height: 38,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: appPrimaryMaterialColor)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: isOfferLoading
                            ? LoadingBlueComponent()
                            : DropdownButton<OfferClass>(
                                // hint: Text(
                                //   "Select category",
                                //   style: TextStyle(
                                //     color: Colors.black,
                                //   ),
                                // ),
//
                                dropdownColor: Colors.white,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                isExpanded: true,
                                value: selectedOfferCat,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOfferCat = value;
                                  });
                                  _getOffer(selectedOfferCat.offerId);
                                },
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text('Select Categories'),
                                ),
                                items: offerCatList.map(
                                  (OfferClass offer) {
                                    return DropdownMenuItem<OfferClass>(
                                      child: Text(offer.offerName),
                                      value: offer,
                                    );
                                  },
                                ).toList(),
                              ),
                      ),

//                          DropdownButtonHideUnderline(
//                        child: DropdownButton(
//                          hint: dropdownValue == null
//                              ? Text(
//                                  "Select category",
//                                  style: TextStyle(
//                                    color: Colors.black,
//                                  ),
//                                )
//                              : Text(dropdownValue),
//                          dropdownColor: Colors.white,
//                          icon: Icon(
//                            Icons.arrow_drop_down,
//                            size: 40,
//                            color: Colors.black,
//                          ),
//                          isExpanded: true,
//                          value: dropdownValue,
//                          items: [
//                            "Sports",
//                            "Entertainment",
//                            "Politics",
//                            "Religion"
//                          ].map((value) {
//                            return DropdownMenuItem<String>(
//                                value: value, child: Text(value));
//                          }).toList(),
//                          onChanged: (value) {
//                            setState(() {
//                              dropdownValue = value;
//                            });
//                          },
//                        ),
//                      ),
                    )),
              ),
              Expanded(
                child: isLoading == true
                    ? LoadingBlueComponent()
                    : offerList.length > 0
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            // scrollDirection: Axis.horizontal,
                            itemCount: offerList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OfferComponent(
                                offerData: offerList[index],
                              );
                            })
                        : Center(child: Text("No Data Found...!")),
              ),
            ],
          ),
        ));
  }
}
