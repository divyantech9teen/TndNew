import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'CategoryProfileComponent.dart';
import 'DirectoryProfileComponent.dart';

class SubCategoryComponent extends StatefulWidget {
  var catData;
  SubCategoryComponent({this.catData});
  @override
  _SubCategoryComponentState createState() => _SubCategoryComponentState();
}

class _SubCategoryComponentState extends State<SubCategoryComponent> {
  List catList = [];
  bool isLoading = true;
  @override
  void initState() {
    _getSubCat();
    _profile();
  }

  String isMember = "";
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //print(widget.catData["memberOf"]);
  // }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMember = prefs.getString(Session.ismember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Center(
            child: Text(
              "Category",
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
        body: isLoading == true
            ? LoadingBlueComponent()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                // scrollDirection: Axis.horizontal,
                itemCount: catList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      isMember == "true"
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new CategoryProfileComponent(
                                    catData: catList[index],
                                  )))
                          : Container();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 22, left: 12, right: 12),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[100], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400].withOpacity(0.2),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: Row(
                          children: [
                            Container(
                              width: 130,
                              height: 210,
                              decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.grey[100]),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
//                                Image.asset(
//                                  "assets/z.jpeg",
//                                  fit: BoxFit.cover,
//                                )
                                      Image.network(
                                    "${catList[index]["img"]}",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "${catList[index]["name"]}",
//                                      "abc",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 3.0),
//                                       child: Text(
//                                         "${catList[index]["business_category"]}",
// //                                      "xyz",
//                                         overflow: TextOverflow.ellipsis,
//                                         textAlign: TextAlign.start,
//                                         style: TextStyle(
//                                             color: Colors.grey[700],
//                                             fontStyle: FontStyle.italic,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 5.0),
//                                       child: Text(
//                                         "${catList[index]["mobile"]}",
// //                                      "9915297227",
//                                         overflow: TextOverflow.ellipsis,
//                                         textAlign: TextAlign.start,
//                                         style: TextStyle(
//                                             color: Colors.grey[700],
//                                             fontStyle: FontStyle.italic,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "${catList[index]["company_name"]}",
//                                      "ITFUTURz",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            // fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "${catList[index]["about_business"]}",
//                                      "sharma@gmail.com",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            // fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }

  _getSubCat() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {"bid": widget.catData["_id"]};
        print("oooooooooooooooooooooooooo" + widget.catData["_id"]);
        Services.PostForList(
                api_name: 'admin/usersInBusinessCategory', body: body)
            .then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              catList = ResponseList;
            });
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
}
