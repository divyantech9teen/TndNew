import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';

class AddOfferScreen extends StatefulWidget {
  @override
  _AddOfferScreenState createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  String img, userName = "";
  final _formkey = new GlobalKey<FormState>();
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  String _format = 'yyyy-MMMM-dd';
  DateTime _date = DateTime.now();
  DateTime _expiredate = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController postedBy = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController instaLink = TextEditingController();
  TextEditingController fbLink = TextEditingController();
  TextEditingController linkinLink = TextEditingController();
  TextEditingController twitterLink = TextEditingController();
  TextEditingController whatsappLink = TextEditingController();
  TextEditingController mailLink = TextEditingController();
  TextEditingController youtubeLink = TextEditingController();
  TextEditingController description = TextEditingController();
  String linkedProjectHintText = "Select Category";
  //project
  List siteList = [];
  String siteId;
  var siteType = "";
  void _showBirthDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _date,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
          date.text = _date.toString().split(" ")[0];
        });
        print(_date);
      },
    );
  }

  void _showExpireDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _expiredate,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _expiredate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _expiredate = dateTime;
          expiryDate.text = _expiredate.toString().split(" ")[0];
        });
        print(_expiredate);
      },
    );
  }

  bool isOfferLoading = true;
  bool isLoading = false;
  List offerList = [];
  List offerList1 = [];
  List<OfferClass> offerCatList = [];
  OfferClass selectedOfferCat;

  @override
  void initState() {
    _getOfferCat();
  }

  File _Image;
  _getOfferCat() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getState1().then((responseList) async {
          setState(() {
            isOfferLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              offerCatList = responseList;
              selectedOfferCat = responseList[0];
              print(offerCatList[0]);
            });
            //_getOffer(selectedOfferCat.offerId);
            //_getOffer(responseList[0].offerId);
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

  _offer(String id) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isOfferLoading = true;
        });
        var body = {"MastercategoryId": id};
        print(body);
        Services.PostForList(api_name: 'admin/getMasterSubcategory', body: body)
            .then((tabResponseList) async {
          setState(() {
            isOfferLoading = false;
          });
          if (tabResponseList.length > 0) {
            setState(() {
              List offerList11 = [];
              offerList11 = tabResponseList;
              offerList1 = offerList11[0];

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

  Future getFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  Future getFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15, bottom: 10),
                      child: Text(
                        "Add Photo",
                        style: TextStyle(
                          fontSize: 22,
                          color: appPrimaryMaterialColor,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/camera.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Take Photo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/gallery.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Choose from Gallery",
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0, bottom: 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: appPrimaryMaterialColor,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
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
        title: Center(
          child: Text(
            "Add Offer",
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
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appPrimaryMaterialColor[400])),
                  child: DropdownButtonHideUnderline(
                    child: isOfferLoading
                        ? LoadingBlueComponent()
                        : DropdownButton<OfferClass>(
//                                hint: dropdownValue == null
//                                    ? Text(
//                                        "Select category",
//                                        style: TextStyle(
//                                          color: Colors.black,
//                                        ),
//                                      )
//                                    : Text(dropdownValue),
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
                                print(selectedOfferCat.offerId);
                                _offer(selectedOfferCat.offerId);
                              });
                              //_getOffer(selectedOfferCat.offerId);
                            },
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
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: appPrimaryMaterialColor[400])),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                          color: Colors.black,
                        ),
                        value: siteId,
                        isExpanded: true,
                        items: offerList1?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item["CategoryName"]),
                                value: item["_id"].toString(),
                              );
                            })?.toList() ??
                            [],
                        hint: Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                          ),
                          child: Text(linkedProjectHintText),
                        ),
                        onChanged: (value) {
                          setState(() {
                            siteId = value;
                            siteType = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 47,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                    ),
                    TextFormField(
                      controller: title,
                      keyboardType: TextInputType.text,
                      validator: (cname) {
                        if (cname.length == 0) {
                          return 'Please enter title ';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 16),
                      cursorColor: appPrimaryMaterialColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 15.0, bottom: 1, left: 1, right: 1),
                        hintText: "Title",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500),
                        prefixIcon: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2.0, left: 10, right: 10),
                            child: Icon(
                              Icons.title,
                              color: appPrimaryMaterialColor,
                            ),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: appPrimaryMaterialColor[400]),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: appPrimaryMaterialColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                          child: TextFormField(
                            controller: date,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 16),
                            cursorColor: appPrimaryMaterialColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 15.0, bottom: 1, left: 15, right: 1),
                              hintText: "Select Starting Date",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w500),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  _showBirthDate();
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.date_range,
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: appPrimaryMaterialColor[400]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: appPrimaryMaterialColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Container(
                          height: 42,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                          child: TextFormField(
                            controller: expiryDate,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 16),
                            cursorColor: appPrimaryMaterialColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 15.0, bottom: 1, left: 15, right: 1),
                              hintText: "Select Expiry Date",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w500),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  _showExpireDate();
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.date_range,
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(
                                    color: appPrimaryMaterialColor[400]),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: appPrimaryMaterialColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: instaLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter Instagram link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/instagram.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: fbLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter Facebook link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/facebook.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: linkinLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter LinkedIn link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/linkedin.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: twitterLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter Twitter link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/twitter.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: whatsappLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter Whatsapp link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/whatsapp2.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: mailLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter Mail link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/gmail.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Container(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: TextFormField(
                    controller: youtubeLink,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 16),
                    cursorColor: appPrimaryMaterialColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          top: 15.0, bottom: 1, left: 1, right: 1),
                      hintText: "Enter Youtube link",
                      hintStyle: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                      prefixIcon: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 10, right: 10),
                          child: Image.asset('assets/youtu.png',
                              width: 30, height: 30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: appPrimaryMaterialColor[400]),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: appPrimaryMaterialColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Stack(
                  children: [
                    Container(
                      //height: 130,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: appPrimaryMaterialColor[400], width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: appPrimaryMaterialColor.withOpacity(0.2),
                        //       blurRadius: 2.0,
                        //       spreadRadius: 2.0,
                        //       offset: Offset(3.0, 5.0))
                        // ]
                      ),
                    ),
                    TextFormField(
                      controller: description,
                      maxLines: 5,
                      maxLength: 400,
                      maxLengthEnforced: true,
                      validator: (cname) {
                        if (cname.length == 0) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      style: TextStyle(fontSize: 16),
                      cursorColor: appPrimaryMaterialColor,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        counterText: "",
                        contentPadding: EdgeInsets.only(
                            top: 15, bottom: 1, left: 1, right: 1),
                        hintText: "Description",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500),
                        prefixIcon: Icon(
                          Icons.sticky_note_2_outlined,
                          color: appPrimaryMaterialColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: appPrimaryMaterialColor[400]),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: appPrimaryMaterialColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xff16B8FF), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: [
                        BoxShadow(
                            color: appPrimaryMaterialColor.withOpacity(0.2),
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 5.0))
                      ]),
                  child: _Image != null
                      ? Image.file(_Image)
                      : Center(child: Text("Select Image")),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.top + 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 25, right: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: RaisedButton(
                      color: appPrimaryMaterialColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        _settingModalBottomSheet();
                      },
                      child: Text("Upload Image",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17))),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: RaisedButton(
                      color: appPrimaryMaterialColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        _addOffers();
                      },
                      child: Text("Add Offer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addOffers() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          String filename = "";
          String filePath = "";
          File compressedFile;
          if (_Image != null) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(_Image.path);

            compressedFile = await FlutterNativeImage.compressImage(
              _Image.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round(),
            );

            filename = _Image.path.split('/').last;
            filePath = compressedFile.path;
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();

          FormData body = FormData.fromMap({
            "userId": prefs.getString(Session.CustomerId),
            "title": title.text,
            "bannerImage": (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                    filename: filename.toString())
                : null,
            "dateTime": date.text,
            "offerExpire": expiryDate.text,
            "details": description.text,
            "faceBook": fbLink.text,
            "instagram": instaLink.text,
            "linkedIn": linkinLink.text,
            "twitter": twitterLink.text,
            "youTube": youtubeLink.text,
            "mail": mailLink.text,
            "Mastercategory": selectedOfferCat.offerId,
            "subcategory": siteId,
            /* "businessCategory": selectedOfferCat.offerId*/
          });
          print(body.fields);

          Services.PostForList(api_name: 'admin/offer', body: body).then(
              (responseList) async {
            setState(() {
              isLoading = false;
            });
            if (responseList.length > 0) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              // setState(() {
              //   prefs.setString(Session.CustomerName, txtName.text);
              //   prefs.setString(Session.CustomerCompanyName, txtCName.text);
              //   prefs.setString(Session.CustomerEmailId, txtEmail.text);
              //   prefs.setString(Session.CustomerPhoneNo, txtMobileNumber.text);
              //   prefs.setString(Session.spouse_name, txtSpouseName.text);
              //   prefs.setString(Session.number_of_child, txtChildrenCount.text);
              //   prefs.setString(Session.about_business, txtAboutBusiness.text);
              //   prefs.setString(Session.experience, txtExperience.text);
              //   prefs.setString(Session.achievement, txtachievement.text);
              //   prefs.setString(Session.linkedIn, linkedIn.text);
              //   prefs.setString(Session.faceBook, facebook.text);
              //   prefs.setString(Session.youTube, youTube.text);
              //   prefs.setString(Session.instagram, instagram.text);
              //   prefs.setString(Session.twitter, twitter.text);
              //   prefs.setString(Session.gender, Gender);
              //   prefs.setString(Session.spouse_birth_date,
              //       responseList[0]["spouse_birth_date"]);
              //   prefs.setString(Session.CustomerImage, responseList[0]["img"]);
              // });
              Navigator.of(context).pushNamed('/HomePage');
              Fluttertoast.showToast(
                  msg: "Offer Added Successfully",
                  gravity: ToastGravity.BOTTOM);
            }

            setState(() {
              isLoading = false;
            });
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "Something Went Wrong");
            //showMsg("something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill all the fields...");
    }
  }
}
