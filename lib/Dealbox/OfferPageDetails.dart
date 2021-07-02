import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

import 'DealOffersDetails.dart';

class OfferPageDetails extends StatefulWidget {
  String image;
  String Sid, Mid;

  OfferPageDetails({this.Sid, this.Mid});

  @override
  _OfferPageDetailsState createState() => _OfferPageDetailsState();
}

class _OfferPageDetailsState extends State<OfferPageDetails> {
  bool isLoading = true;
  List offerList = [];
  List searchresult = [];
  final TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    _getOffer(widget.Mid.toString(), widget.Sid.toString());
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
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
                        color: Colors.grey[400], fontWeight: FontWeight.w500),
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: appPrimaryMaterialColor[400]),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: appPrimaryMaterialColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              isLoading == true
                  ? LoadingBlueComponent()
                  : searchresult.length > 0
                      ? ListView.builder(
                          itemCount: searchresult.length,
                          itemBuilder: (context, index) => Container(
                                // height: 200,
                                child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    searchresult[index]
                                                            ["UserId"][0]
                                                        ["companylogo"]),
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
                                                    "${searchresult[index]["UserId"][0]["company_name"]}",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
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
                                                          "${searchresult[index]["UserId"][0]["name"]}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600]))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          searchresult[index]["UserId"][0]
                                                      ["address"] ==
                                                  ""
                                              ? Container()
                                              : Divider(),
                                          searchresult[index]["UserId"][0]
                                                      ["address"] ==
                                                  ""
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${searchresult[index]["UserId"][0]["address"]}",
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                    maxLines: 3,
                                                  ),
                                                ),
                                          searchresult[index]["UserId"][0]
                                                      ["address"] ==
                                                  ""
                                              ? Container()
                                              : Divider(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DealOffersDetails(
                                                            Data: searchresult[
                                                                index],
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
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "VIEW MORE",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ))
                      : offerList.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: offerList.length,
                              itemBuilder: (context, index) => Container(
                                    // height: 200,
                                    child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(offerList[
                                                                index]["UserId"]
                                                            [0]["companylogo"]),
                                                    // child: Image.network(
                                                    //     offerList[index]["companylogo"]),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${offerList[index]["UserId"][0]["company_name"]}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 3.0,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.person_pin,
                                                            size: 20,
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          Text(
                                                              "${offerList[index]["UserId"][0]["name"]}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              offerList[index]["UserId"][0]
                                                          ["address"] ==
                                                      ""
                                                  ? Container()
                                                  : Divider(),
                                              offerList[index]["UserId"][0]
                                                          ["address"] ==
                                                      ""
                                                  ? Container()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "${offerList[index]["UserId"][0]["address"]}",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                              offerList[index]["UserId"][0]
                                                          ["address"] ==
                                                      ""
                                                  ? Container()
                                                  : Divider(),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DealOffersDetails(
                                                                Data: offerList[
                                                                    index],
                                                              )));
                                                },
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    height: 40,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "VIEW MORE",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
            ],
          ),
        ));
  }

  void searchOperation(String searchText) {
    print("hello");
    searchresult.clear();
    if (searchText != "") {
      for (int i = 0; i < offerList.length; i++) {
        String data1 = offerList[i]["CategoryName"];
        if (offerList[i]["CategoryName"]
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

  _getOffer(String Mid, String Sid) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        var body = {"Mastercategory": Mid, "subcategory": Sid};
        Services.PostForList(
                api_name: 'admin/getOfferbySubcategory', body: body)
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
