import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

import 'DealOffersDetails.dart';

class OfferPageDetails extends StatefulWidget {
  String image;
  String offerData;

  OfferPageDetails({this.offerData});

  @override
  _OfferPageDetailsState createState() => _OfferPageDetailsState();
}

class _OfferPageDetailsState extends State<OfferPageDetails> {
  bool isLoading = true;
  List offerList = [];

  @override
  void initState() {
    _getOffer(widget.offerData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Deal Offers",
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
      body: isLoading == true
          ? LoadingBlueComponent()
          : offerList.length > 0
              ? ListView.builder(
                  itemCount: offerList.length,
                  itemBuilder: (context, index) => Container(
                        // height: 200,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            offerList[index]["companylogo"]),
                                        // child: Image.network(
                                        //     offerList[index]["companylogo"]),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${offerList[index]["company_name"]}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 3.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.person_pin,
                                                size: 20,
                                                color: Colors.grey[300],
                                              ),
                                              Text(
                                                  "${offerList[index]["name"]}",
                                                  style: TextStyle(
                                                      color: Colors.grey[600]))
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  offerList[index]["address"] == ""
                                      ? Container()
                                      : Divider(),
                                  offerList[index]["address"] == ""
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${offerList[index]["address"]}",
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                            maxLines: 3,
                                          ),
                                        ),
                                  offerList[index]["address"] == ""
                                      ? Container()
                                      : Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DealOffersDetails(
                                                    offerData: offerList[index]
                                                        ["_id"],
                                                    userData: offerList[index],
                                                  )));
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "VIEW MORE",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ))
              : Center(child: Text("No Data Found!")),
    );
  }

  _getOffer(String offerId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        var body = {"bid": "${offerId}"};
        Services.PostForList(
                api_name: 'admin/usersInBusinessCategory', body: body)
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
}
