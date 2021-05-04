import 'dart:io';
import 'dart:ui';
import 'dart:developer';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart' as formdata;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_slider/image_slider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';
import 'package:the_national_dawn/Screens/NotificationPopUp.dart';
import 'package:the_national_dawn/offlineDatabase/db_handler.dart';

class HomeScreen extends StatefulWidget {
  String instagram, facebook, linkedIn, twitter, whatsapp;

  HomeScreen(
      {this.instagram,
      this.facebook,
      this.linkedIn,
      this.twitter,
      this.whatsapp});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  String fcmToken = "";
  String qrData;
  var _name;
  var _comp_name;
  var _mobileNo;
  var _email;
  bool isVerified;
  var img;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isFCMtokenLoading = false;
  String barCode;
  DBHelper dbHelper;
  Future<List<Visitorclass>> visitor;

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString(Session.CustomerName);
      _comp_name = prefs.getString(Session.CustomerCompanyName);
      _email = prefs.getString(Session.CustomerEmailId);
      img = prefs.getString(Session.CustomerImage);
      _mobileNo = prefs.getString(Session.CustomerPhoneNo);
      isVerified = prefs.getBool(Session.isVerified);
      /* qrData =
          _name + "," + _comp_name + "," + _email + "," + img + "," + _mobileNo;*/
    });
    print(" Value of Member $isVerified");
  }

  Future scanVisitor() async {
    try {
      String barCode = await BarcodeScanner.scan();
      var qrtext = barCode.toString().split(",");
      print(qrtext[3]);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 9.0, top: 6),
                        child: Icon(
                          Icons.clear,
                          size: 19,
                          color: Colors.grey,
                        ),
                      ),
                    )),
                Container(
                    height: 80,
                    width: 100,
                    child: Image.network(Image_URL + "${qrtext[3]}")),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Name : ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${qrtext[0]}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(children: [
                    Text(
                      "Company Name : ",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${qrtext[1]}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ], mainAxisAlignment: MainAxisAlignment.center),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(children: [
                    Text(
                      "Email : ",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${qrtext[2]}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ], mainAxisAlignment: MainAxisAlignment.center),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0),
                  child: Row(children: [
                    Text(
                      "Phone : ",
                      /*"${widget.whtscall}",*/
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${qrtext[4]}",
                      /*"${widget.whtscall}",*/
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ], mainAxisAlignment: MainAxisAlignment.center),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 21.0, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //launch(('mailto:// ${widget.emaildata}'));
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.mail,
                            color: Colors.white,
                            size: 19,
                          ),
                          backgroundColor: appPrimaryMaterialColor,
                          radius: 19,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            // launch(('tel:// ${widget.phonedata}'));
                          },
                          child: CircleAvatar(
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 19,
                            ),
                            backgroundColor: appPrimaryMaterialColor,
                            radius: 19,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          /* launchwhatsapp(
                              phone: "${widget.whtspdata}",
                              message: "${widget.whtscall}");*/
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: CircleAvatar(
                            child: Image.asset(
                              "assets/whatsapp.png",
                              width: 21,
                              color: Colors.white,
                            ),
                            backgroundColor: appPrimaryMaterialColor,
                            radius: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    dbHelper.insertVisitor(Visitorclass(
                        qrtext[0].toString(),
                        qrtext[1].toString(),
                        qrtext[2].toString(),
                        qrtext[3].toString(),
                        qrtext[4].toString()));
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 25, left: 9, right: 9),
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: appPrimaryMaterialColor, width: 1)),
                      child: Center(
                        child: Text(
                          "Ok",
                          // "${widget.contactdata}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 4,
                  color: appPrimaryMaterialColor,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            /*Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : " + "${qrtext[0]}"),
                Text("Company Name : " + "${qrtext[1]}"),
                Text("Email : " + "${qrtext[2]}"),
                Text("Image : " + "${qrtext[3]}"),
                Text("Phone : " + "${qrtext[4]}"),
                Center(
                  child: RaisedButton(
                      child: Text("ok"),
                      onPressed: () {
                        dbHelper.insertVisitor(Visitorclass(
                            qrtext[0].toString(),
                            qrtext[1].toString(),
                            qrtext[2].toString(),
                            qrtext[3].toString(),
                            qrtext[4].toString()));
                      }),
                )
              ],
            ),*/
          );
        },
      );
    } catch (e) {
      setState(() => this.barCode = 'Unknown error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _bannerImage();
    _profile();
    getToken();
  }

  getToken() async {
    await _firebaseMessaging.getToken().then((token) {
      setState(() {
        fcmToken = token;
      });
      _updateFCMtoken(fcmToken);
      print('----------->' + '${token}');
    });
  }

  List listB = [
    {
      "lable": "Daily News",
      "image": "assets/news.png",
      // "screenName": "/DailyNewScreen",
      "screenName": "/DailyNewsDashBoard",
    },
    {
      "lable": "Business Stories",
      "image": "assets/bussiness.png",
      "screenName": "/BussinessStoryScreen",
    },
    {
      "lable": " E-Paper",
      "image": "assets/directory.png",
      "screenName": "/PaperScreen",
    },
    {
      "lable": "Offers",
      "image": "assets/offers.png",
      // "screenName": "/OfferScreen",
      "screenName": "/OfferPage",
    },
    {
      "lable": "Success Stories",
      "image": "assets/success.png",
      "screenName": "/StoriesScreen",
    },
    {
      "lable": "Calendar",
      "image": "assets/calender.png",
      "screenName": "/CalenderScreen",
    },
    {
      "lable": "Business Card",
      "image": "assets/news.png",
      //"screenName": "/BusinessCardScreen",
      "screenName": "/Dashboard",
    },
    {
      "lable": "Bookmark",
      "image": "assets/category.png",
      "screenName": "/BookMarkScreen",
    },

    {
      "lable": "IBC",
      "image": "assets/ibc1.png",
      "screenName": "/DirectoryScreen"
    }
    // {
    //   "lable": "Category",
    //   "image": "assets/category.png",
    //   "screenName": "/CategoryScreen",
    // },
  ];

  List imgList = [];
  bool isBannerLoading = true;

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertboxLogout();
      },
    );
  }

  _updateFCMtoken(String token) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isFCMtokenLoading = true;
        });
        var body = {"mobile": "${_mobileNo}", "fcmToken": "${token}"};
        Services.postForSave(apiname: 'api/registration/verify', body: body)
            .then((response) async {
          if (response.IsSuccess == true && response.Data == "1") {
            setState(() {
              isFCMtokenLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isFCMtokenLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

  _scanDialog(var data) {}

  @override
  Widget build(BuildContext context) {
    print(imgList);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: FittedBox(
          child: Row(
            children: [
              Text(
                "The",
                style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Text(
                  "National",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Dawn",
                style: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          /*GestureDetector(
            onTap: () {
              _settingModalBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 18, bottom: 19),
              child: Image.asset("assets/scan.png"),
            ),
          ),*/
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/NotificationScreen');
              },
              child: Image.asset("assets/bell.png")),
        ],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          color: Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset(
                  'assets/LOGO1.png',
                  fit: BoxFit.contain,
                ),
                decoration: BoxDecoration(
                  color: appPrimaryMaterialColor[200],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/MemberDetailScreen');
                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 4),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/user.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  title: Text(
                    "Profile",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/ReferEarnScreen');
                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 4),
                    child: Container(
                        height: 26,
                        width: 26,
                        child: Image.asset(
                          "assets/hand-shake.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  title: Text(
                    "Refer and Earn  \u{20B9} 100",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/MyEcardScreen');
                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 4),
                    child: Container(
                        height: 26,
                        width: 26,
                        child: Image.asset(
                          "assets/visitor-card.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  title: Text(
                    "My Scan Card",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/MyOfferScreen');
                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 4),
                    child: Container(
                        height: 26,
                        width: 26,
                        child: Image.asset(
                          "assets/my_offer.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  title: Text(
                    "My Offers",
                  ),
                ),
              ),
              /*    Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/PermissionNoti');
                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 4),
                    child: Container(
                        height: 26,
                        width: 26,
                        child: Icon(
                          Icons.notifications,
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  title: Text(
                    "Notification",
                  ),
                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 4),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/logout.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  title: Text(
                    "Logout",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(
              color: appPrimaryMaterialColor,
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              //margin: EdgeInsets.all(10),
//                decoration: BoxDecoration(
//                    //borderRadius: BorderRadius.circular(10),
//                    border:
//                        Border.all(width: 2, color: appPrimaryMaterialColor)),
              child: isBannerLoading == true
                  ? Center(child: LoadingBlueComponent())
                  : ImageSlider(
                      /// Shows the tab indicating circles at the bottom
                      showTabIndicator: false,

                      /// Cutomize tab's colors
                      tabIndicatorColor: Colors.grey[400],

                      /// Customize selected tab's colors
                      tabIndicatorSelectedColor: Colors.black,

                      /// Height of the indicators from the bottom
                      tabIndicatorHeight: 16,

                      /// Size of the tab indicator circles
                      tabIndicatorSize: 12,

                      /// tabController for walkthrough or other implementations
                      tabController: tabController,

                      /// Animation curves of sliding
                      curve: Curves.fastOutSlowIn,

                      /// Width of the slider
                      width: MediaQuery.of(context).size.width,

                      /// Height of the slider
                      height: 200,

                      /// If automatic sliding is required
                      autoSlide: true,

                      /// Time for automatic sliding
                      duration: new Duration(seconds: 7),

                      /// If manual sliding is required
                      allowManualSlide: true,

                      /// Children in slideView to slide
                      children: imgList.map((link) {
                        return GestureDetector(
                          onTap: () {
                            print(link['title']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsBannerDetail(
                                    newsData: link,
                                  ),
                                ));
                          },
                          child: new Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(8.0),
                                child: link['featured_img_src'] == null
                                    ? Image.asset('assets/appLogo.png')
                                    : Image.network(
                                        link['featured_img_src'],
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 220,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: Colors.white.withOpacity(0.45),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              link['title'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
            Divider(
              color: appPrimaryMaterialColor,
            ),
            // for (int i = 0; i < listB.length; i++) ...[
            //   custombox(
            //       listB[i]["lable"], listB[i]["image"], listB[i]["screenName"]),
            // ],
            // GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //     childAspectRatio: 1.1,
            //   ),
            //   itemCount: listB.length,
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) => custombox(
            //     listB[index]["lable"],
            //     listB[index]["image"],
            //     listB[index]["screenName"],
            //   ),
            // ),
            StaggeredGridView.countBuilder(
              crossAxisCount: 3,
              itemCount: listB.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return custombox(
                  listB[index]["lable"],
                  listB[index]["image"],
                  listB[index]["screenName"],
                );
              },
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            )
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        color: Colors.white,
                        child: QrImage(
                          data: "${qrData}",
                          size: 230.0,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Text(
                        "Scan this QRCode to get contact information.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    margin: EdgeInsets.only(bottom: 20, top: 5),
                    child: MaterialButton(
                      color: appPrimaryMaterialColor,
                      onPressed: () {
                        scanVisitor();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Scan QRCode",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  /*Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              elevation: 5,
                              textColor: Colors.white,
                              color: appPrimaryMaterialColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Share",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15)),
                                  )
                                ],
                              ),
                              onPressed: () {
                                //_getViewCardId("no");
                                // bool val = true;
                                */ /*  if (val != null && val == true)
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) =>
                                              CardShareComponent(
                                        memberId: cardData,
                                        memberName: name,
                                        isRegular: val,
                                        memberType: MemberType,
                                        shareMsg: ShareMsg,
                                        IsActivePayment: IsActivePayment,
                                      ),
                                    ),
                                  );
                                else
                                  showMsg(
                                      'Your trial is expired please contact to digital card team for renewal.\n\nThank you,\nRegards\nDigital Card');

                        },*/ /*
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              elevation: 5,
                              textColor: Colors.white,
                              color: appPrimaryMaterialColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("View Card",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15)),
                                  )
                                ],
                              ),
                              onPressed: () async {
                                // _getViewCardId("yes");
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                        )
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          );
        });
  }

  Widget custombox(
    String lable,
    String image,
    String screenName,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(screenName);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.height * 0.1,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                // color: appPrimaryMaterialColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: FittedBox(
                  // fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      lable,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: appPrimaryMaterialColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _bannerImage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isBannerLoading = true;
        });
        formdata.FormData body =
            formdata.FormData.fromMap({"news_category": "local-news"});
        Services.PostForList1(api_name: 'custom/slider_news', body: body).then(
            (bannerresponselist) async {
          setState(() {
            isBannerLoading = false;
          });
          if (bannerresponselist.length > 0) {
            setState(() {
              imgList = bannerresponselist;
              tabController =
                  TabController(length: imgList.length, vsync: this);
              //set "data" here to your variable
            });
            log("My Data" + imgList.toString());
          } else {
            Fluttertoast.showToast(msg: "Banner Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isBannerLoading = false;
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

class AlertboxLogout extends StatefulWidget {
  @override
  _AlertboxLogoutState createState() => _AlertboxLogoutState();
}

class _AlertboxLogoutState extends State<AlertboxLogout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Logout",
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
      content: new Text(
        "Are you sure want to Logout!",
        style: TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(
            "Ok",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/LoginScreen', (route) => false);
            Navigator.pushNamedAndRemoveUntil(
                context, '/GuestDashBoard', (route) => false);
          },
        ),
      ],
    );
  }
}

class ScanAlert extends StatefulWidget {
  @override
  _ScanAlertState createState() => _ScanAlertState();
}

class _ScanAlertState extends State<ScanAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Scan",
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
