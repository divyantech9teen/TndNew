import 'dart:convert';
import 'dart:developer';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/GuestScreens/GuestHome.dart';
import 'package:the_national_dawn/Screens/HomeCalendarScreen.dart';
import 'package:the_national_dawn/Screens/HomeCategoryScreen.dart';
import 'package:the_national_dawn/Screens/HomeNetworkScreen.dart';
import 'package:the_national_dawn/Screens/HomeScreen.dart';
import 'package:the_national_dawn/Screens/HomeStoriesScreen.dart';
import 'package:the_national_dawn/Screens/OfferScreen.dart';
import 'package:the_national_dawn/offlineDatabase/db_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qrData;
  var _name = "";
  var _comp_name;
  var _mobileNo;
  var _email;
  var img;
  String barCode = "";
  DBHelper dbHelper = DBHelper();
  Future<List<Visitorclass>> visitor;

  @override
  void initState() {
    _profile();
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString(Session.CustomerName);
      _comp_name = prefs.getString(Session.CustomerCompanyName);
      _email = prefs.getString(Session.CustomerEmailId);
      img = prefs.getString(Session.CustomerImage);
      _mobileNo = prefs.getString(Session.CustomerPhoneNo);
      qrData = _name +
          "," +
          _comp_name +
          "," +
          _email +
          "," +
          "$img" +
          "," +
          _mobileNo;
    });
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
                          onTap: () {},
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
                    print(qrtext);
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

  bool clickedCentreFAB =
      false; //boolean used to handle container animation which expands from the FAB
  int _currentIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HomeCalendarScreen(),
    HomeScreen(),
    HomeStoriesScreen(),
    GuestHome()
  ];

  /*void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _widgetOptions[_currentIndex],
        bottomNavigationBar: ConvexAppBar(
          activeColor: appPrimaryMaterialColor,
          color: appPrimaryMaterialColor[200],
          style: TabStyle.fixedCircle,
          backgroundColor: Colors.white,
          initialActiveIndex: _currentIndex,
          height: 60,
          top: -30,
          curveSize: 100,
          onTap: (index) {
            if (index == 2) {
              _settingModalBottomSheet(context);
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
            print(_currentIndex);
          },
          items: [
            TabItem(
                icon: Image.asset(
              "assets/Home.png",
              color: _currentIndex == 0
                  ? appPrimaryMaterialColor
                  : appPrimaryMaterialColor[300],
            )),
            TabItem(
                icon: Image.asset(
              "assets/calender.png",
              color: _currentIndex == 1
                  ? appPrimaryMaterialColor
                  : appPrimaryMaterialColor[300],
            )),
            TabItem(
                icon: Image.asset(
              "assets/scan.png",
              color: Colors.white,
            )),
            TabItem(
                icon: Image.asset(
              "assets/success.png",
              color: _currentIndex == 3
                  ? appPrimaryMaterialColor
                  : appPrimaryMaterialColor[300],
            )),
            TabItem(
                icon: Image.asset(
              "assets/network.png",
              color: _currentIndex == 4
                  ? appPrimaryMaterialColor
                  : appPrimaryMaterialColor[300],
            )),
          ],
        ),
        /* _widgetOptions[_selectedIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked, //specify the location of the FAB
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _onItemTapped(2);
            },
            tooltip: "Centre FAB",
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Image.asset("assets/category.png", color: Colors.white),
            ),
            elevation: 4.0,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              height: 63,
              margin: EdgeInsets.only(left: 9.0, right: 9.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  */ /*IconButton(
                    //update the bottom app bar view each time an item is clicked
                    onPressed: () {
                      _onItemTapped(0);
                    },
                    iconSize: 27.0,
                    icon: Icon(
                      Icons.home,
                      //darken the icon if it is selected or else give it a different color
                      color: _selectedIndex == 0
                          ? Colors.blue.shade900
                          : Colors.grey.shade400,
                    ),
                  ),*/ /*
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(0);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 26,
                            height: 24,
                            child: Image.asset("assets/Home.png",
                                color: _selectedIndex == 0
                                    ? appPrimaryMaterialColor
                                    : Colors.grey[500]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _selectedIndex == 0
                                      ? appPrimaryMaterialColor
                                      : Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 22,
                            height: 24,
                            child: Image.asset("assets/calender.png",
                                color: _selectedIndex == 1
                                    ? appPrimaryMaterialColor
                                    : Colors.grey[500]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "Calendar",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _selectedIndex == 1
                                      ? appPrimaryMaterialColor
                                      : Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //to leave space in between the bottom app bar items and below the FAB
                  SizedBox(
                    width: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(3);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 22,
                            height: 24,
                            child: Image.asset("assets/success.png",
                                color: _selectedIndex == 3
                                    ? appPrimaryMaterialColor
                                    : Colors.grey[500]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "Stories",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _selectedIndex == 3
                                      ? appPrimaryMaterialColor
                                      : Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(4);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 22,
                            height: 24,
                            child: Image.asset("assets/network.png",
                                color: _selectedIndex == 4
                                    ? appPrimaryMaterialColor
                                    : Colors.grey[500]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "1-2-1",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _selectedIndex == 4
                                      ? appPrimaryMaterialColor
                                      : Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //to add a space between the FAB and BottomAppBar
            shape: CircularNotchedRectangle(),
            //color of the BottomAppBar
            color: Colors.white,
          ),*/

        /* bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 17, left: 25, right: 25, top: 8),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                // boxShadow: <BoxShadow>[
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.grey[200]),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.grey[400],
                    spreadRadius: 1.0,
                  ),
                ],
                //   ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                    primaryColor: Colors.white,
                    textTheme: Theme.of(context)
                        .textTheme
                        .copyWith(caption: TextStyle(color: Colors.white)),
                  ),
                  child: BottomNavigationBar(
                    // backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.fixed,

                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: _selectedIndex == 0
                                  ? Icon(
                                      Icons.home,
                                      color: appPrimaryMaterialColor,
                                    )
                                  : Icon(
                                      Icons.home,
                                      color: Colors.grey[300],
                                    )

//                        Image.asset(
//                          _selectedIndex == 0
//                              ? "assets/Home.png"
//                              : "assets/Home.png",
//                          // color: Colors.white,
//                        ),
                              ),
                        ),
                        //   icon: Icon(Icons.home),
                        title: FittedBox(child: Text('Home')),
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              _selectedIndex == 1
                                  ? "assets/calender.png"
                                  : "assets/unCalender.png",
                            ),
                          ),
                        ),
                        title: FittedBox(child: Text('Calendar')),
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              _selectedIndex == 2
                                  ? "assets/category.png"
                                  : "assets/unCategory.png",
                              //  color: Colors.white,
                            ),
                          ),
                        ),
                        title: FittedBox(child: Text('Category')),
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              _selectedIndex == 3
                                  ? "assets/success.png"
                                  : "assets/unSuccess.png",
                            ),
                          ),
                        ),
                        title: FittedBox(child: Text('Stories')),
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              _selectedIndex == 4
                                  ? "assets/network.png"
                                  : "assets/unNetwork.png",
                              // color: Colors.white,
                            ),
                          ),
                        ),
                        title: FittedBox(
                          child: Text('1-2-1'),
                        ),
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: appPrimaryMaterialColor,
                    unselectedItemColor: Colors.grey[400],
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            ),
          ),*/
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
}
