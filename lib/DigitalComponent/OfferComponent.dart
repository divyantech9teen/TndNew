import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/DigitalScreens/EditOffer.dart';
import 'package:the_national_dawn/DigitalScreens/OfferDetail.dart';

class OfferComponent extends StatefulWidget {
  // final OfferClass offerClass;
  //
  // const OfferComponent(this.offerClass);

  //by rinki

  var offerData;

  OfferComponent({this.offerData});

  @override
  _OfferComponentState createState() => _OfferComponentState();
}

class _OfferComponentState extends State<OfferComponent> {
  bool isLoading = false;
  bool showComponent = true;
  var date;

  @override
  void initState() {
    funDate();
  }

  funDate() {
    String dateData = " ${widget.offerData["validtilldate"]}";
    date = dateData.split('-');
    print("-------------------->${date}");
    // funMonth("${date[2]}");
  }

  // DeleteOffer() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var data = {'type': 'offer', 'id': widget.offerData};
  //   Future res = Services.DeleteOffer(data);
  //   res.then((data) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     if (data != null && data.ERROR_STATUS == false) {
  //       Fluttertoast.showToast(
  //           msg: "Data Deleted",
  //           backgroundColor: Colors.green,
  //           gravity: ToastGravity.TOP);
  //       //Navigator.pushReplacementNamed(context, '/Dashboard');
  //       setState(() {
  //         showComponent = false;
  //       });
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Data Not Deleted" + data.MESSAGE,
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

  DeleteOffer() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {"offerId": widget.offerData["_id"]};
        Services.postForSave(apiname: 'card/deleteoffer', body: body).then(
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
    return showComponent
        ? Stack(
            children: <Widget>[
              Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          //Navigator.pushNamed(context, "/OfferDetail");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OfferDetail(
                                        //    offerClass: widget.offerClass)));
                                        offerData: widget.offerData,
                                        offerdate:
                                            "${date[2]}-${date[1]}-${date[0]}",
                                      )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.offerData["title"],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: cnst.appcolor)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                        '${widget.offerData["description"].length > 65 ? widget.offerData["description"].substring(0, 65) : widget.offerData["description"]}...',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[600])),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Available till :",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[600])),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              "${date[2]}-${date[1]}-${date[0]}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: cnst.appcolor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: cnst.buttoncolor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            child: Text("Interested",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                          ),
                        )*/
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditOffer(
                                          offerData: widget.offerData,
                                          offerDate:
                                              "${date[2]}-${date[1]}-${date[0]}",
                                        ))),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Icon(Icons.edit),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text("Delete Confirmation"),
                                    content: new Text(
                                        "Are you sure you want to delete this offer?"),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      new FlatButton(
                                        child: new Text("Ok"),
                                        onPressed: () {
                                          DeleteOffer();
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
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Icon(Icons.delete),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))
                    : Container(),
              )
            ],
          )
        : Container();
  }
}
