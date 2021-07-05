import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/DigitalComponent/ImagePickerHandlerComponent.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> with TickerProviderStateMixin, ImagePickerListener {
  bool isLoading = false;
  String MemberId = "";
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDesc = new TextEditingController();

  DateTime date = new DateTime.now();

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

  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(Session.digital_Id);

    if (memberId != null && memberId != "")
      setState(() {
        MemberId = memberId;
      });
  }

//by rinki
  SaveService() async {
    if (txtTitle.text != '' && txtDesc.text != '') {
      setState(() {
        isLoading = true;
      });
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
            "title": txtTitle.text.replaceAll("'", "''"),
            "description": txtDesc.text.replaceAll("'", "''"),
            "memberid": prefs.getString(cnst.Session.MemberId),
            "serviceimg" : (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                filename: filename.toString())
                : null,

          });

          // var body = {
          //   "title": txtTitle.text.replaceAll("'", "''"),
          //   "description": txtDesc.text.replaceAll("'", "''"),
          //   "memberid": prefs.getString(cnst.Session.MemberId),
          //   "serviceimg" : (filePath != null && filePath != '')
          // ? await MultipartFile.fromFile(filePath,
          // filename: filename.toString())
          //     : null,

          // };
          log("====${body}");
          log(prefs.getString(Session.CustomerId));
          Services.PostForList4(api_name: 'card/addservice', body: body).then(
              (subCatResponseList) async {
            log("a0");
            setState(() {
              isLoading = false;
            });
            if (subCatResponseList.length > 0) {
              log("a1");

              Fluttertoast.showToast(
                  msg: "Data Saved",
                  backgroundColor: Colors.green,
                  gravity: ToastGravity.TOP);
              Navigator.popAndPushNamed(context, '/Dashboard');
            } else {
              log("a2");
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
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Data First",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.yellow,
          textColor: Colors.black,
          fontSize: 15.0);
    }
  }

  // SaveService() async {
  //   if (txtTitle.text != '' && txtDesc.text != '') {
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     var data = {
  //       'type': 'service',
  //       'title': txtTitle.text.replaceAll("'", "''"),
  //       'desc': txtDesc.text.replaceAll("'", "''"),
  //       'memberid': MemberId.toString(),
  //     };
  //
  //     Future res = Services.SaveService(data);
  //     res.then((data) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       if (data != null && data.ERROR_STATUS == false) {
  //         Fluttertoast.showToast(
  //             msg: "Data Saved",
  //             backgroundColor: Colors.green,
  //             gravity: ToastGravity.TOP);
  //         Navigator.popAndPushNamed(context, '/Dashboard');
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: "Data Not Saved" + data.MESSAGE,
  //             backgroundColor: Colors.red,
  //             gravity: ToastGravity.TOP,
  //             toastLength: Toast.LENGTH_LONG);
  //       }
  //     }, onError: (e) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       Fluttertoast.showToast(
  //           msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
  //     });
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Please Enter Data First",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.TOP,
  //         backgroundColor: Colors.yellow,
  //         textColor: Colors.black,
  //         fontSize: 15.0);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Service'),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      border: new Border.all(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextFormField(
                    controller: txtDesc,
                    maxLines: 10,
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
                      if (isLoading == false) this.SaveService();
                    },
                    child: setUpButtonChild(),
                  ) /*RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            elevation: 5,
                            textColor: Colors.white,
                            color: cnst.buttoncolor,
                            child: Text("Add Service",
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

  Widget setUpButtonChild() {
    if (isLoading == false) {
      return new Text(
        "Add Service",
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

}
