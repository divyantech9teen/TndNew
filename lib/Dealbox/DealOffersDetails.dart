import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';

class DealOffersDetails extends StatefulWidget {
  var Data;
  DealOffersDetails({this.Data});
  @override
  _DealOffersDetailsState createState() => _DealOffersDetailsState();
}

class _DealOffersDetailsState extends State<DealOffersDetails> {
  bool isLoading = true;
  List offerList = [];

  @override
  void initState() {
    print(widget.Data.runtimeType);
    /*  _getOfferbyUser("${widget.offerData}");*/
  }

  void _settingModalBottomSheet(var offerData) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return new OfferBottomsheet(
            offerData: offerData,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Offer Description",
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
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey[100])),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              widget.Data["UserId"][0]["companylogo"]),
                          // child: Image.network(
                          //     widget.userData["companylogo"]),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.Data["UserId"][0]["company_name"]}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person_pin,
                                  size: 20,
                                  color: Colors.grey[300],
                                ),
                                Text("${widget.Data["UserId"][0]["name"]}",
                                    style: TextStyle(color: Colors.grey[600]))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              listContainer()
            ]))
        /* : Center(
                  child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text("No Data Found!"),
                )),*/
        );
  }

  listContainer() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) => Container(
              //height: 120,
              child: Card(
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: appPrimaryMaterialColor[200],
                            height: 130,
                            width: 120,
                            child: widget.Data["bannerImage"] == ""
                                ? Image.asset(
                                    "assets/appLogo.png",
                                    height: 100,
                                    width: 100,
                                  )
                                : Image.network(
                                    "${widget.Data["bannerImage"]}",
                                    height: 130,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, top: 6),
                                child: Text(
                                  " ${widget.Data["title"]}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, bottom: 12),
                                child: Text(" ${widget.Data["details"]}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, bottom: 12),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _settingModalBottomSheet(widget.Data);
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Details",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        height: 35,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Buy",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

/*  _getOfferbyUser(String userId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        var body = {"id": "${userId}"};
        Services.PostForList(api_name: 'admin/getOfferbyUser', body: body).then(
            (subCatResponseList) async {
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
  }*/
}

class OfferBottomsheet extends StatefulWidget {
  var offerData;

  OfferBottomsheet({this.offerData});

  @override
  _OfferBottomsheetState createState() => _OfferBottomsheetState();
}

class _OfferBottomsheetState extends State<OfferBottomsheet> {
  String exDate;
  var date;
  var date2 = DateTime.now();
  var difference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("Expiry Date :${widget.offerData["offerExpire"]}");
    funDate();
  }

  funDate() {
    //
    // date = exDate.split('-');
    // int day = int.parse("${date[0]}");
    // int month = int.parse("${date[1]}");
    // int year = int.parse("${date[2]}");
    // var expiryDate = DateTime(year, month, day);
    // print("expiryDate-------------------->${expiryDate}");
    // setState(() {
    //   difference = expiryDate.difference(date2).inDays;
    // });
    // print("difference-------------------->${difference}");
    //
    // setState(() {
    //   exDate = "${widget.offerData["offerExpire"]}";
    // });
    setState(() {
      exDate = "${widget.offerData["offerExpire"]}";
    });
    if (exDate != "") {
      log("==========================");

      date = exDate.split('-');
      int year = int.parse("${date[2]}");
      int month = int.parse("${date[1]}");
      int day = int.parse("${date[0]}");
      var expiryDate = DateTime(year, month, day);
      print("expiryDate-------------------->${expiryDate}");
      setState(() {
        difference = expiryDate.difference(date2).inDays;
      });
    }

    print("difference-------------------->${difference}");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          // height: 190.0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    color: Colors.black,
                    height: 40,
                    width: 250,
                    child: Center(
                      child: Text(
                        "Offer Terms & Conditions",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 20, bottom: 2),
                  child: Text(
                    "Offer Title",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    "${widget.offerData["title"]}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8, bottom: 2),
                  child: Text(
                    "Offer Description",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    "${widget.offerData["details"]}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8, bottom: 2),
                  child: Text(
                    "Validity Until",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    "${widget.offerData["offerExpire"]}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8, bottom: 2),
                  child: Text(
                    "Valid Days",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),*/
                /*      Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    difference >= 0
                        ? "Offer Expired"
                        : "${difference}" + " Days to Go",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8, bottom: 2),
                  child: Text(
                    "Social Media Link",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SocialMediaComponent(
                  facebook: widget.offerData["faceBook"],
                  instagram: widget.offerData["instagram"],
                  linkedIn: widget.offerData["linkedIn"],
                  twitter: widget.offerData["twitter"],
                  mail: widget.offerData["mail"],
                  youtube: widget.offerData["youTube"],
                  whatsapp: widget.offerData["whatsApp"],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0, right: 15),
                //   child: Text(
                //     "11:00 AM- 11:00 PM",
                //     style: TextStyle(
                //         color: Colors.grey,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 16),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 15.0, right: 15, top: 8, bottom: 2),
                //   child: Text(
                //     "Valid For",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 16),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15.0, right: 15),
                //   child: Text(
                //     "Dine in",
                //     style: TextStyle(
                //         color: Colors.grey,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 16),
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
