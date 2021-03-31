import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;
import 'package:the_national_dawn/DigitalComponent/ImagePickerHandlerComponent.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class AddOffer extends StatefulWidget {
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer>
    with TickerProviderStateMixin, ImagePickerListener {
  bool isLoading = false;
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDate = new TextEditingController();
  TextEditingController txtDesc = new TextEditingController();

  DateTime date = new DateTime.now();
  String MemberId = "";

  @override
  void initState() {
    super.initState();
    GetLocalData();
    _controller = new AnimationController(

      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    txtDate.text = date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(Session.digital_Id);

    if (memberId != null && memberId != "")
      setState(() {
        MemberId = memberId;
      });
  }

  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  String _format = 'yyyy-MMMM-dd';
  DateTime _offerDate;

  void _showOfferDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _offerDate,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _offerDate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _offerDate = dateTime;
        });
        print(_offerDate);
      },
    );
  }

  SaveOffer() async {
    if (txtTitle.text != '' && txtDate.text != '' && txtDesc.text != '') {
      setState(() {
        isLoading = true;
      });

      // String img = '';
      // if (_image != null) {
      //   List<int> imageBytes = await _image.readAsBytesSync();
      //   String base64Image = base64Encode(imageBytes);
      //   img = base64Image;
      // }
      //
      // print('base64 Img : $img');

      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          String filename = "";
          String filePath = "";
          File compressedFile;
          if (_image != null) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(_image.path);

            compressedFile = await FlutterNativeImage.compressImage(
              _image.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round(),
            );

            filename = _image.path.split('/').last;
            filePath = compressedFile.path;
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          FormData body = FormData.fromMap({
            "title": txtTitle.text,
            "description": txtDesc.text,
            "validtilldate": _offerDate.toString().split(" ")[0],
            //    "imagecode": img,
            "imagecode": (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                    filename: filename.toString())
                : null,
            "memberId": prefs.getString(cnst.Session.MemberId),
          });
          // var body = {
          //   "title": txtTitle.text,
          //   "description": txtDesc.text,
          //   "validtilldate": _offerDate.toString().split(" ")[0],
          //   //    "imagecode": img,
          //   "imagecode": _image,
          //   "memberId": prefs.getString(cnst.Session.MemberId),
          // };
          print(prefs.getString(Session.CustomerId));
          Services.PostForList4(api_name: 'card/addoffer', body: body).then(
              (subCatResponseList) async {
            print("a0");
            setState(() {
              isLoading = false;
            });
            if (subCatResponseList.length > 0) {
              print("a1");

              Fluttertoast.showToast(
                  msg: "Data Saved",
                  backgroundColor: Colors.green,
                  gravity: ToastGravity.TOP);
              Navigator.popAndPushNamed(context, '/Dashboard');
            } else {
              print("a2");
              Fluttertoast.showToast(
                  msg: "Data Not Saved",
                  backgroundColor: Colors.red,
                  gravity: ToastGravity.TOP,
                  toastLength: Toast.LENGTH_LONG);
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
    //   var data = {
    //     'type': 'offer',
    //     'title': txtTitle.text,
    //     'desc': txtDesc.text,
    //     'imagecode': img,
    //     'validtilldate': txtDate.text,
    //     'memberid': MemberId.toString(),
    //   };
    //
    //   var data1 = {
    //     'type': 'offer',
    //     'title': txtTitle.text,
    //     'imagecode': img,
    //   };
    //
    //   print(data1);
    //   Future res = Services.SaveGallery(data1);
    //   res.then((data) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     if (data != null) {
    //       Fluttertoast.showToast(
    //           msg: "Data Saved",
    //           backgroundColor: Colors.green,
    //           gravity: ToastGravity.TOP);
    //       Navigator.pushReplacementNamed(context, '/Dashboard');
    //     } else {
    //       Fluttertoast.showToast(
    //           msg: "Data Not Saved" + data.MESSAGE,
    //           backgroundColor: Colors.red,
    //           gravity: ToastGravity.TOP,
    //           toastLength: Toast.LENGTH_LONG);
    //     }
    //   }, onError: (e) {
    //     setState(() {
    //       isLoading = false;
    //     });
    //     Fluttertoast.showToast(
    //         msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
    //   });
    // }
    //
    else {
      Fluttertoast.showToast(
          msg: "Please Enter Data First",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Offer'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          //margin: EdgeInsets.only(top: 110),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      border: new Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    controller: txtTitle,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title), hintText: "Title"),
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black),
                  ),
                  //height: 40,
                  width: MediaQuery.of(context).size.width - 40,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Row(
                //     children: <Widget>[
                //       GestureDetector(
                //         onTap: () {
                //           DatePicker.showDatePicker(
                //             context,
                //             dateFormat: 'dd-mmm-yyyy',
                //             initialDateTime: DateTime.now(),
                //             locale: _locale,
                //             onCancel: () => print('onCancel'),
                //             onChange: (dateTime, List<int> index) {},
                //             onConfirm: (dateTime, List<int> index) {
                //               setState(() {
                //                 txtDate.text = dateTime.year.toString() +
                //                     '-' +
                //                     dateTime.year.toString() +
                //                     '-' +
                //                     date.toString();
                //               });
                //             },
                //           );
                //           // DatePicker.showDatePicker(
                //           //   context,
                //           //   showTitleActions: true,
                //           //   locale: 'en',
                //           //   minYear: 1970,
                //           //   maxYear: 2020,
                //           //   initialYear: DateTime.now().year,
                //           //   initialMonth: DateTime.now().month,
                //           //   initialDate: DateTime.now().day,
                //           //   cancel: Text('cancel'),
                //           //   confirm: Text('confirm'),
                //           //   dateFormat: 'dd-mmm-yyyy',
                //           //   onChanged: (year, month, date) {},
                //           //   onConfirm: (year, month, date) {
                //           //     txtDate.text = year.toString() +
                //           //         '-' +
                //           //         month.toString() +
                //           //         '-' +
                //           //         date.toString();
                //           //   },
                //           // );
                //         },
                //         child: Container(
                //           padding: EdgeInsets.symmetric(horizontal: 0),
                //           decoration: BoxDecoration(
                //               color: Color.fromRGBO(255, 255, 255, 0.5),
                //               border: new Border.all(width: 1),
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(5))),
                //           child: TextFormField(
                //             controller: txtDate,
                //             enabled: false,
                //             decoration: InputDecoration(
                //                 prefixIcon: Icon(Icons.calendar_today),
                //                 hintText: "Date"),
                //             keyboardType: TextInputType.number,
                //             style: TextStyle(color: Colors.black),
                //           ),
                //           //height: 40,
                //           width: MediaQuery.of(context).size.width - 80,
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(left: 10),
                //       ),
                //       GestureDetector(
                //           onTap: () {
                //             txtDate.text = "";
                //           },
                //           child: Icon(Icons.close)),
                //       Padding(
                //         padding: EdgeInsets.only(left: 5),
                //       ),
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    _showOfferDate();
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      child: _offerDate == null
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Select Date',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                              '${_offerDate.day}/${_offerDate.month}/${_offerDate.year}',
                              style: TextStyle(fontSize: 17),
                            ))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      border: new Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    maxLines: 5,
                    controller: txtDesc,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        hintText: "Description"),
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(color: Colors.black),
                  ),
                  //height: 40,
                  width: MediaQuery.of(context).size.width - 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () => imagePicker.showDialog(context),
                    child: new Center(
                      child: _image == null
                          ? Container(
                              height: MediaQuery.of(context).size.width - 100,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: new BoxDecoration(
                                //  color: const Color(0xff7c94b6),
                                border: Border.all(
                                    color: cnst.buttoncolor, width: 1.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(60.0)),
                              ),
                              child: Center(child: Text("Select Image"))

                              // Image.asset(
                              //   "images/logo.png",
                              //   height: MediaQuery.of(context).size.width - 100,
                              //   width: MediaQuery.of(context).size.width - 100,
                              // ),
                              )
                          : new Container(
                              height: MediaQuery.of(context).size.width - 100,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image: new ExactAssetImage(_image.path),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: cnst.buttoncolor, width: 2.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(60.0)),
                              ),
                            ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10),
                  child: MaterialButton(
                    color: cnst.buttoncolor,
                    minWidth: MediaQuery.of(context).size.width - 20,
                    onPressed: () {
                      if (isLoading == false) this.SaveOffer();
                    },
                    child: setUpButtonChild(),
                  ) /*RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        elevation: 5,
                        textColor: Colors.white,
                        color: cnst.buttoncolor,
                        child: Text("Add Offer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        onPressed: () {
                          Navigator.pushNamed(context, "/Dashboard");
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)))*/
                  ,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

  Widget setUpButtonChild() {
    if (isLoading == false) {
      return new Text(
        "Add Offer",
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }
}
