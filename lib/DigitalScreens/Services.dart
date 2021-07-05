import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/DigitalComponent/HeaderComponent.dart';
import 'package:the_national_dawn/DigitalComponent/LoadinComponent.dart';
import 'package:the_national_dawn/DigitalComponent/NoDataComponent.dart';
import 'package:the_national_dawn/DigitalComponent/ServiceComponent.dart';

class MemberServices extends StatefulWidget {
  @override
  _MemberServicesState createState() => _MemberServicesState();
}

class _MemberServicesState extends State<MemberServices> {
  List serviceList = [];
  bool isLoading = true;

  @override
  void initState() {
    _getService();
  }

  _getService() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var body = {"userid": prefs.getString(Session.MemberId)};
        print("userid: ${prefs.getString(Session.MemberId)}");
        Services.PostForList4(api_name: 'card/getuserservice', body: body).then(
            (ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              serviceList = ResponseList;
            });
            print(ResponseList);
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No Data Found");
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/HomePage');
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: cnst.buttoncolor,
          onPressed: () => Navigator.pushNamed(context, "/AddService"),
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              HeaderComponent(
                title: "Services",
                image: "assets/servicehearde.jpg",
                boxheight: 150,
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 160,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(top: 100),
                  child:

                      //by rinki
                      isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                                strokeWidth: 3,
                              ),
                            )
                          : serviceList.length > 0
                              ? ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: serviceList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ServiceComponent(
                                      serviceData: serviceList[index],
                                    );
                                  },
                                )
                              : NoDataComponent()
                  //
                  // FutureBuilder<List<ServicesClass>>(
                  //   future: Services.GetMemberServices(),
                  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //     return snapshot.connectionState == ConnectionState.done
                  //         ? snapshot.hasData
                  //             ? ListView.builder(
                  //                 padding: EdgeInsets.all(0),
                  //                 shrinkWrap: true,
                  //                 itemCount: snapshot.data.length,
                  //                 itemBuilder: (BuildContext context, int index) {
                  //                   return ServiceComponent(snapshot.data[index]);
                  //                 },
                  //               )
                  //             : NoDataComponent()
                  //         : LoadinComponent();
                  //   },
                  // ),
                  )
            ],
          ),
        ));
  }
}
