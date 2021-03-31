import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  var _name;
  var _comp_name;
  var _mobileNo;
  var _email;
  var img;
  String qrData;

  @override
  void initState() {
    super.initState();
    _profile();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString(Session.CustomerName);
      _comp_name = prefs.getString(Session.CustomerCompanyName);
      _email = prefs.getString(Session.CustomerEmailId);
      img = prefs.getString(Session.CustomerImage);
      _mobileNo = prefs.getString(Session.CustomerPhoneNo);
    });
    /*setState(() {
      qrData =
          _name + "," + _comp_name + "," + _email + "," + img + "," + _mobileNo;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "My Profile",
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
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 18, left: 10, bottom: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/UpdateProfileScreen');
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
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 15.0, bottom: 25.0),
          child: Column(
            children: <Widget>[
              img != ""
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Colors.blue,
                        //shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: appPrimaryMaterialColor.withOpacity(0.2),
                              spreadRadius: 2,
                              offset: Offset(3, 5)),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: img != null
                            ? NetworkImage(img)
                            : AssetImage('assets/user2.png'),
                        //child: Image.asset("assets/10.jpeg",fit: BoxFit.cover,),
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Colors.blue,
                        //shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: appPrimaryMaterialColor.withOpacity(0.2),
                              spreadRadius: 2,
                              offset: Offset(3, 5)),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          "assets/051-user.png",
                        ),
                        //child: Image.asset("assets/10.jpeg",fit: BoxFit.cover,),
                      )),
              SizedBox(
                height: 22,
              ),
              Container(
                height: 131,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: appPrimaryMaterialColor[50], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                    boxShadow: [
                      BoxShadow(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "${_name}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Manager",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      Text("${_comp_name}",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 133,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: appPrimaryMaterialColor[50], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                    boxShadow: [
                      BoxShadow(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              color: Color(0xff16B8FF),
                              size: 22,
                            ),
                            Image.asset("assets/whatsapp.png"),
                            Icon(
                              Icons.email,
                              color: Colors.redAccent,
                              size: 22,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
//                                              "+91-8488848476",
                              "${_mobileNo}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            Text(
//                                                "+91-9723131314",
                                "${_mobileNo}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(
//                                                "xsantosh7@gmail.com",
                                "${_email}",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 42,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[500], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/MemberDetailScreen');
                  },
                  child: Center(
                      child: Text(
                    "More Information",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  )),
                ),
              ),
              /* SizedBox(
                height: 18,
              ),
              Container(
                height: 42,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[500], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: appPrimaryMaterialColor.withOpacity(0.2),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(3.0, 5.0))
                    ]),
                child: Center(
                    child: Text(
                  "Share QR to scan",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 21),
                )),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
