import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';

class HomeStoriesScreen extends StatefulWidget {
  @override
  _HomeStoriesScreenState createState() => _HomeStoriesScreenState();
}

class _HomeStoriesScreenState extends State<HomeStoriesScreen> {
  List successStoriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    _getSucccessStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "Success Stories",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontSize: 18,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        /* leading: Padding(
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
        ),*/
      ),
      backgroundColor: Colors.white,
      body: isLoading == true
          ? Center(child: LoadingBlueComponent())
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              // scrollDirection: Axis.horizontal,
              itemCount: successStoriesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top + 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                child: Container(
                                  height: 420,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    "${successStoriesList[index]["storyImage"]}",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15, top: 25),
                                      child: Text(""))),
//                               Positioned(
//                                   bottom: 15.0,
//                                   right: 10.0,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       // Navigator.push(context,MaterialPageRoute(builder:(context) =>Offers()));
//                                     },
//                                     child: Container(
//                                       height: 74,
//                                       width: 74,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         shape: BoxShape.circle,
//                                         boxShadow: [
//                                           BoxShadow(
//                                               blurRadius: 2,
//                                               color: Color(0xff16B8FF)
//                                                   .withOpacity(0.2),
//                                               spreadRadius: 3,
//                                               offset: Offset(1, 6))
//                                         ],
//                                       ),
//                                       child: CircleAvatar(
//                                           radius: 30.0,
//                                           backgroundColor: Colors.white,
//                                           child: Icon(Icons.star,
//                                               color: appPrimaryMaterialColor,
//                                               size: 45.0)
// //                            Image.asset("assets/Lheart.png"),
//                                           //Icon(Icons.favorite,color: Colors.red,size: 45.0,),
//                                           ),
//                                     ),
//                                   )
// //                      child: CircleAvatar(
// //                        radius: 40,
// //                          backgroundColor: Colors.white,
// //                          child: Icon(Icons.favorite,color: Colors.red,size: 45.0,))
//                                   ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
//                                    height: 80,
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey[200],
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                "${successStoriesList[index]["storyImage"]}",
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0),
                                            child: Text(
                                              "${successStoriesList[index]["headline"]}",
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color:
                                                      appPrimaryMaterialColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SocialMediaComponent(
                                facebook: successStoriesList[index]["faceBook"],
                                instagram: successStoriesList[index]
                                    ["instagram"],
                                linkedIn: successStoriesList[index]["linkedIn"],
                                twitter: successStoriesList[index]["twitter"],
                                whatsapp: successStoriesList[index]["whatsApp"],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Social Media links",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              Divider(),
                              Text(
                                  "${successStoriesList[index]["storyContent"]}",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Color(0xff010101),
                                      fontSize: 14,
                                      letterSpacing: 0)),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey[200],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
    );
  }

  _getSucccessStories() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        var body = {};
        Services.PostForList(
          api_name: 'admin/getSuccessStory',
        ).then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              successStoriesList = ResponseList;
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
