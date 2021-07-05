import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';

class NetworkingProfile extends StatefulWidget {
  var directoryData;
  NetworkingProfile({this.directoryData});
  @override
  _NetworkingProfileState createState() => _NetworkingProfileState();
}

class _NetworkingProfileState extends State<NetworkingProfile> {
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
            "Profile",
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
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 15.0, bottom: 25.0),
          child: Column(
            children: <Widget>[
              Container(
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
                    backgroundImage:
                        NetworkImage("${widget.directoryData["img"]}"),
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
                        // "Mr. Natasha Goel",
                        "${widget.directoryData["name"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      widget.directoryData["business_category"] == null
                          ? Text("")
                          : Text(
                              "${widget.directoryData["business_category"]["categoryName"]}",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                      Text(
//                                          "Future Group Info Soft",
                          "${widget.directoryData["company_name"]}",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                child: Container(
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
                              offset: Offset(3.0, 4.0))
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Social Media links",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        SocialMediaComponent(
                          facebook: widget.directoryData["faceBook"],
                          instagram: widget.directoryData["instagram"],
                          linkedIn: widget.directoryData["linkedIn"],
                          twitter: widget.directoryData["twitter"],
                          whatsapp: widget.directoryData["whatsApp"],
                        ),
                      ],
                    )),
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
                              "${widget.directoryData["mobile"]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            Text(
//                                                "xsantosh7@gmail.com",
                                "${widget.directoryData["email"]}",
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
              /*  Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 1.0,
                                spreadRadius: 1.0,
                                offset: Offset(2.0, 4.0))
                          ]),
                      child: Center(
                          child: Text(
                        "Share my details",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(2.0, 4.0))
                            ]),
                        child: Center(
                            child: Text(
                          "Share QR to scan",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        )),
                      ),
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
