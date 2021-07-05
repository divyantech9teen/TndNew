import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/DigitalScreens/EditService.dart';

class ServiceComponent extends StatefulWidget {
  // final ServicesClass servicesClass;
  //
  // const ServiceComponent(this.servicesClass);

  var serviceData;

  ServiceComponent({this.serviceData});

  @override
  _ServiceComponentState createState() => _ServiceComponentState();
}

class _ServiceComponentState extends State<ServiceComponent> {
  // bool isExpand = false;
  // DeleteService() async {
  //   var data = {'type': 'service', 'id': widget.servicesClass.Id};
  //   Future res = Services.DeleteService(data);
  //   res.then((data) {
  //     if (data != null && data.ERROR_STATUS == false) {
  //       Fluttertoast.showToast(
  //           msg: "Data Deleted",
  //           backgroundColor: Colors.green,
  //           gravity: ToastGravity.TOP);
  //       Navigator.pushReplacementNamed(context, '/Dashboard');
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Data Not Deleted" + data.MESSAGE,
  //           backgroundColor: Colors.red,
  //           gravity: ToastGravity.TOP,
  //           toastLength: Toast.LENGTH_LONG);
  //     }
  //   }, onError: (e) {
  //     Fluttertoast.showToast(
  //         msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
  //   });
  // }
  bool isLoading = false;

  DeleteService() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {"serviceId": widget.serviceData["_id"]};
        print("======body${body}");
        Services.postForSave(apiname: 'card/deleteservice', body: body).then(
            (response) async {
          setState(() {
            isLoading = false;
          });
          if (response.IsSuccess == true && response.Data == "1") {
            Fluttertoast.showToast(
                msg: "Data Deleted",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP);
            Navigator.popAndPushNamed(context, '/Dashboard');
          } else {
            Fluttertoast.showToast(
                msg: "Data Not Deleted",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                toastLength: Toast.LENGTH_LONG);
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        //margin: EdgeInsets.symmetric(vertical: 5),
        child: ExpansionTile(
          /*trailing: Icon(isExpand?Icons.cancel:Icons.add),
          onExpansionChanged: ((value) {
            setState(() {
              isExpand=!isExpand;
            });
          }),*/
          title: Text(widget.serviceData["title"],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700])),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: MediaQuery.of(context).size.width - 40,
              child: Text(widget.serviceData["description"],
                  style: TextStyle(fontSize: 15, color: Colors.grey[700])),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Delete Confirmation"),
                          content: new Text(
                              "Are you sure you want to delete this service?"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Ok"),
                              onPressed: () {
                                DeleteService();
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.restore_from_trash,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditService(
                          serviceData: widget.serviceData,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
