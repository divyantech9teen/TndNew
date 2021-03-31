import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class EditService extends StatefulWidget {
  // final ServicesClass servicesClass;
  // const EditService({Key key, this.servicesClass}) : super(key: key);

  var serviceData;
  EditService({this.serviceData});

  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  bool isLoading = false;
  String MemberId = "";
  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDesc = new TextEditingController();

  DateTime date = new DateTime.now();

  @override
  void initState() {
    super.initState();
    GetLocalData();
    SetData();
  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(Session.digital_Id);

    if (memberId != null && memberId != "")
      setState(() {
        MemberId = memberId;
      });
  }

  SetData() {
    txtTitle.text = widget.serviceData["title"];
    txtDesc.text = widget.serviceData["description"];
  }

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

          SharedPreferences prefs = await SharedPreferences.getInstance();
          var body = {
            'title': txtTitle.text.replaceAll("'", "''"),
            'description': txtDesc.text.replaceAll("'", "''"),
            'serviceId': widget.serviceData["_id"],
          };

          print(prefs.getString(Session.CustomerId));
          Services.PostForList4(api_name: 'card/updateservice', body: body)
              .then((subCatResponseList) async {
            print("a0");
            setState(() {
              isLoading = false;
            });
            if (subCatResponseList.length > 0) {
              print("a1");

              Fluttertoast.showToast(
                  msg: "Service Updated Successfully!",
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
  //       'id': widget.serviceData,
  //     };
  //
  //     Future res = Services.UpdateService(data);
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
          title: Text('Edit Service'),
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
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget setUpButtonChild() {
    if (isLoading == false) {
      return new Text(
        "Update Service",
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
