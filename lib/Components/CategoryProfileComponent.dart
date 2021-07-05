import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';

class CategoryProfileComponent extends StatefulWidget {
  var catData;
  CategoryProfileComponent({this.catData});
  @override
  _CategoryProfileComponentState createState() =>
      _CategoryProfileComponentState();
}

class _CategoryProfileComponentState extends State<CategoryProfileComponent> {
  String memberImg = "";
  String isMember = "";

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //print(widget.catData["memberOf"]);
  // }
  @override
  void initState() {
    setState(() {
      _profile();
    });
  }

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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Center(
          child: Text(
            "Category Profile",
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
              left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      radius: 65,
                      backgroundImage: widget.catData["img"] != null
                          ? NetworkImage("${widget.catData["img"]}")
                          : AssetImage('assets/user2.png'),
                      //child: Image.asset("assets/10.jpeg",fit: BoxFit.cover,),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 5),
                  child: Text(
                    "In Network",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 10),
                  child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: appPrimaryMaterialColor[50], width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(22.0))),
                      child: widget.catData["memberOf"] == null
                          ? Center(child: Text("No Member"))
                          : SizedBox(
                              child: widget.catData["memberOf"].length > 0
                                  ? ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          widget.catData["memberOf"].length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, bottom: 3),
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Image.network(
                                                      "${widget.catData["memberOf"][index]["logo"]}",
                                                      width: 45,
                                                    )),
                                                Text(
                                                    "${widget.catData["memberOf"][index]["memberShipName"]}"),
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                                  : SizedBox(),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8.0, right: 8, bottom: 30),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: appPrimaryMaterialColor[50], width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(22.0))),
                    child: SocialMediaComponent(
                      facebook: widget.catData["faceBook"],
                      instagram: widget.catData["instagram"],
                      linkedIn: widget.catData["linkedIn"],
                      twitter: widget.catData["twitter"],
                      whatsapp: widget.catData["whatsApp"],
                      youtube: widget.catData["youTube"],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 250,
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
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: 25,
                                  color: appPrimaryMaterialColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    'Personal Info',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Name : ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.catData["name"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Date Of Birth : ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.catData["date_of_birth"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Gender : ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.catData["gender"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Spouse Name : ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.catData["spouse_name"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Spouse Birth Date : ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.catData["spouse_birth_date"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 15),
                            child: Row(
                              children: [
                                Text(
                                  "Number Of Child : ",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.catData["number_of_child"]}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: Container(
                        // height: 450,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: appPrimaryMaterialColor[50], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.business,
                                        color: appPrimaryMaterialColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Business Info',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Company Name : ",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      FittedBox(
                                        child: Text(
                                          "${widget.catData["company_name"]}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "company_website : ",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      widget.catData["company_website"] != null
                                          ? Text(
                                              "${widget.catData["company_website"]}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Business Category : ",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        widget.catData["business_category"] !=
                                                null
                                            ? "${widget.catData["business_category"]["categoryName"]}"
                                            : "-",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Address : ",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, right: 12, top: 5),
                                  child: Text(
                                    "${widget.catData["address"]}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    "About Business : ",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, right: 12, bottom: 30),
                                  child: Text(
                                    "${widget.catData["about_business"]}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: appPrimaryMaterialColor[50],
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: appPrimaryMaterialColor
                                          .withOpacity(0.2),
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(3.0, 5.0))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.info,
                                        color: appPrimaryMaterialColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          'More Info',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, left: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Achievement : ",
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      widget.catData["achievement"] != null
                                          ? Text(
                                              "${widget.catData["achievement"]}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            )
                                          : Text(
                                              "-",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "experience : ",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "${widget.catData["experience"]}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mobile : ",
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${widget.catData["mobile"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                    ],
                                  ),
                                ),
                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Email : ",
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text("${widget.catData["email"]}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 20.0, top: 8),
                                //   child: Text("Network Type : ",
                                //       style: TextStyle(
                                //           fontSize: 15,
                                //           color: Colors.grey[500],
                                //           fontWeight:
                                //               FontWeight.w500)),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 20,
                                //       right: 20,
                                //       top: 5,
                                //       bottom: 10),
                                //   child: Container(
                                //       height: 75,
                                //       width: MediaQuery.of(context)
                                //           .size
                                //           .width,
                                //       decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           border: Border.all(
                                //               color:
                                //                   appPrimaryMaterialColor[
                                //                       50],
                                //               width: 1),
                                //           borderRadius:
                                //               BorderRadius.all(
                                //                   Radius.circular(
                                //                       22.0))),
                                //       child:
                                //           widget.catData[
                                //                       "memberOf"] ==
                                //                   null
                                //               ? Center(
                                //                   child: Text(
                                //                       "No Member"))
                                //               : SizedBox(
                                //                   child: widget
                                //                               .catData[
                                //                                   "memberOf"]
                                //                               .length >
                                //                           0
                                //                       ? ListView.builder(
                                //                           physics: BouncingScrollPhysics(),
                                //                           scrollDirection: Axis.horizontal,
                                //                           itemCount: widget.catData["memberOf"].length,
                                //                           itemBuilder: (BuildContext context, int index) {
                                //                             return Padding(
                                //                               padding: const EdgeInsets.only(
                                //                                   left: 5.0,
                                //                                   bottom: 3),
                                //                               child:
                                //                                   Container(
                                //                                 child:
                                //                                     Column(
                                //                                   children: [
                                //                                     Padding(
                                //                                         padding: const EdgeInsets.only(top: 15.0, bottom: 5, left: 5),
                                //                                         child: Image.network(
                                //                                           "${widget.catData["memberOf"][index]["logo"]}",
                                //                                           width: 45,
                                //                                         )),
                                //                                     Text("${widget.catData["memberOf"][index]["memberShipName"]}"),
                                //                                   ],
                                //                                 ),
                                //                               ),
                                //                             );
                                //                           })
                                //                       : SizedBox(),
                                //                 )),
                                // ),
                                SizedBox(
                                  height: 20,
                                )
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 20.0, top: 8),
                                //   child: Text("Social Media : ",
                                //       style: TextStyle(
                                //           fontSize: 15,
                                //           color: Colors.grey[500],
                                //           fontWeight:
                                //               FontWeight.w500)),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       top: 8,
                                //       left: 8.0,
                                //       right: 8,
                                //       bottom: 30),
                                //   child: Container(
                                //     height: 55,
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         border: Border.all(
                                //             color:
                                //                 appPrimaryMaterialColor[
                                //                     50],
                                //             width: 1),
                                //         borderRadius:
                                //             BorderRadius.all(
                                //                 Radius.circular(
                                //                     22.0))),
                                //     child: SocialMediaComponent(
                                //       facebook: widget
                                //           .catData["faceBook"],
                                //       instagram: widget
                                //           .catData["instagram"],
                                //       linkedIn: widget
                                //           .catData["linkedIn"],
                                //       twitter:
                                //           widget.catData["twitter"],
                                //       whatsapp: widget
                                //           .catData["whatsApp"],
                                //       youtube:
                                //           widget.catData["youTube"],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*Stack(
                              children: <Widget>[
                            Column(
                              children: <Widget>[
                                //Make Design
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        margin: EdgeInsets.all(10),
                                        elevation: 3,
                                        child: Container(
                                          //padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 20, bottom: 20),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.business,
                                                            color:
                                                                appPrimaryMaterialColor,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Text(
                                                              'Business Info',
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                ),
                                                TextFormField(
                                                  //   controller: edtCmpName,
                                                  scrollPadding:
                                                      EdgeInsets.all(0),
                                                  decoration: InputDecoration(
                                                      labelText: "Company",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      hintText: "Company"),
                                                  minLines: 1,
                                                  maxLines: 4,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                TextFormField(
                                                  scrollPadding:
                                                      EdgeInsets.all(0),
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          "Business Category:",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      hintText:
                                                          "Business Category"),
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                TextFormField(
                                                  scrollPadding:
                                                      EdgeInsets.all(0),
                                                  decoration: InputDecoration(
                                                      labelText: "Address",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      hintText: "Address"),
                                                  // enabled: isBusinessEditable,
                                                  minLines: 1,
                                                  maxLines: 4,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                TextFormField(
                                                  //  controller: edtBusinessAbout,
                                                  scrollPadding:
                                                      EdgeInsets.all(0),
                                                  decoration: InputDecoration(
                                                      labelText: "About Business",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      hintText: "About Business"),
                                                  //  enabled: isBusinessEditable,
                                                  minLines: 1,
                                                  maxLines: 4,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                              ],
                            ),*/
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      //     DefaultTabController(
      //   length: 3,
      //   child: Column(
      //     children: [
      //       Container(
      //         color: Colors.white,
      //         height: 5,
      //       ),
      //       Material(
      //         color: Colors.white,
      //         child: TabBar(
      //             labelColor: Colors.white,
      //             unselectedLabelColor: Colors.black,
      //             indicatorSize: TabBarIndicatorSize.tab,
      //             indicator: new BubbleTabIndicator(
      //               indicatorHeight: 43,
      //               indicatorRadius: 6,
      //               indicatorColor: appPrimaryMaterialColor[700],
      //               tabBarIndicatorSize: TabBarIndicatorSize.tab,
      //             ),
      //             tabs: [
      //               Tab(
      //                 child: Text(
      //                   'Personal',
      //                 ),
      //               ),
      //               Tab(
      //                 child: Text('Business'),
      //               ),
      //               Tab(
      //                 child: Text('More Info'),
      //               ),
      //             ]),
      //       ),
      //       Expanded(
      //         child: TabBarView(
      //           children: [
      //             SingleChildScrollView(
      //               physics: BouncingScrollPhysics(),
      //               child: Padding(
      //                 padding: const EdgeInsets.only(
      //                     left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
      //                 child: Center(
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: <Widget>[
      //                       Container(
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(80.0),
      //                             color: Colors.blue,
      //                             //shape: BoxShape.circle,
      //                             boxShadow: [
      //                               BoxShadow(
      //                                   blurRadius: 2,
      //                                   color: appPrimaryMaterialColor
      //                                       .withOpacity(0.2),
      //                                   spreadRadius: 2,
      //                                   offset: Offset(3, 5)),
      //                             ],
      //                           ),
      //                           child: CircleAvatar(
      //                             radius: 65,
      //                             backgroundImage: widget.catData["img"] != null
      //                                 ? NetworkImage("${widget.catData["img"]}")
      //                                 : AssetImage('assets/user2.png'),
      //                             //child: Image.asset("assets/10.jpeg",fit: BoxFit.cover,),
      //                           )),
      //                       SizedBox(
      //                         height: 20,
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(
      //                             left: 20.0, top: 8, bottom: 5),
      //                         child: Text(
      //                           "In Network",
      //                           style: TextStyle(
      //                               fontSize: 17,
      //                               fontWeight: FontWeight.w600,
      //                               color: Colors.black),
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(
      //                             left: 5, right: 5, top: 5, bottom: 10),
      //                         child: Container(
      //                             height: 90,
      //                             width: MediaQuery.of(context).size.width,
      //                             decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 border: Border.all(
      //                                     color: appPrimaryMaterialColor[50],
      //                                     width: 1),
      //                                 borderRadius: BorderRadius.all(
      //                                     Radius.circular(22.0))),
      //                             child: widget.catData["memberOf"] == null
      //                                 ? Center(child: Text("No Member"))
      //                                 : SizedBox(
      //                                     child: widget.catData["memberOf"]
      //                                                 .length >
      //                                             0
      //                                         ? ListView.builder(
      //                                             physics:
      //                                                 BouncingScrollPhysics(),
      //                                             scrollDirection:
      //                                                 Axis.horizontal,
      //                                             itemCount: widget
      //                                                 .catData["memberOf"]
      //                                                 .length,
      //                                             itemBuilder:
      //                                                 (BuildContext context,
      //                                                     int index) {
      //                                               return Padding(
      //                                                 padding:
      //                                                     const EdgeInsets.only(
      //                                                         left: 5.0,
      //                                                         bottom: 3),
      //                                                 child: Container(
      //                                                   child: Column(
      //                                                     mainAxisAlignment:
      //                                                         MainAxisAlignment
      //                                                             .center,
      //                                                     crossAxisAlignment:
      //                                                         CrossAxisAlignment
      //                                                             .center,
      //                                                     children: [
      //                                                       Padding(
      //                                                           padding:
      //                                                               const EdgeInsets
      //                                                                       .only(
      //                                                                   left:
      //                                                                       5),
      //                                                           child: Image
      //                                                               .network(
      //                                                             "${widget.catData["memberOf"][index]["logo"]}",
      //                                                             width: 45,
      //                                                           )),
      //                                                       Text(
      //                                                           "${widget.catData["memberOf"][index]["memberShipName"]}"),
      //                                                     ],
      //                                                   ),
      //                                                 ),
      //                                               );
      //                                             })
      //                                         : SizedBox(),
      //                                   )),
      //                       ),
      //                       // Padding(
      //                       //   padding:
      //                       //       const EdgeInsets.only(left: 20.0, top: 8),
      //                       //   child: Text("Social Media : ",
      //                       //       style: TextStyle(
      //                       //           fontSize: 15,
      //                       //           color: Colors.grey[500],
      //                       //           fontWeight: FontWeight.w500)),
      //                       // ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(
      //                             top: 8, left: 8.0, right: 8, bottom: 30),
      //                         child: Container(
      //                           height: 55,
      //                           decoration: BoxDecoration(
      //                               color: Colors.white,
      //                               border: Border.all(
      //                                   color: appPrimaryMaterialColor[50],
      //                                   width: 1),
      //                               borderRadius: BorderRadius.all(
      //                                   Radius.circular(22.0))),
      //                           child: SocialMediaComponent(
      //                             facebook: widget.catData["faceBook"],
      //                             instagram: widget.catData["instagram"],
      //                             linkedIn: widget.catData["linkedIn"],
      //                             twitter: widget.catData["twitter"],
      //                             whatsapp: widget.catData["whatsApp"],
      //                             youtube: widget.catData["youTube"],
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 10,
      //                       ),
      //                       Container(
      //                         height: 250,
      //                         width: MediaQuery.of(context).size.width,
      //                         decoration: BoxDecoration(
      //                             color: Colors.white,
      //                             border: Border.all(
      //                                 color: appPrimaryMaterialColor[50],
      //                                 width: 1),
      //                             borderRadius:
      //                                 BorderRadius.all(Radius.circular(22.0)),
      //                             boxShadow: [
      //                               BoxShadow(
      //                                   color: appPrimaryMaterialColor
      //                                       .withOpacity(0.2),
      //                                   blurRadius: 2.0,
      //                                   spreadRadius: 2.0,
      //                                   offset: Offset(3.0, 5.0))
      //                             ]),
      //                         child: Center(
      //                           child: Padding(
      //                             padding: const EdgeInsets.only(left: 20.0),
      //                             child: Column(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceAround,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: <Widget>[
      //                                 Padding(
      //                                   padding:
      //                                       const EdgeInsets.only(top: 15.0),
      //                                   child: Row(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.center,
      //                                     children: <Widget>[
      //                                       Icon(
      //                                         Icons.person,
      //                                         size: 25,
      //                                         color: appPrimaryMaterialColor,
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             left: 5),
      //                                         child: Text(
      //                                           'Personal Info',
      //                                           textAlign: TextAlign.center,
      //                                           style: TextStyle(
      //                                               fontSize: 18,
      //                                               fontWeight: FontWeight.w600,
      //                                               color: Colors.black),
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(top: 15),
      //                                   child: Row(
      //                                     children: [
      //                                       Text(
      //                                         "Name : ",
      //                                         style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500),
      //                                       ),
      //                                       Text(
      //                                         "${widget.catData["name"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(top: 5),
      //                                   child: Row(
      //                                     children: [
      //                                       Text(
      //                                         "Date Of Birth : ",
      //                                         style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500),
      //                                       ),
      //                                       Text(
      //                                         "${widget.catData["date_of_birth"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(top: 5),
      //                                   child: Row(
      //                                     children: [
      //                                       Text(
      //                                         "Gender : ",
      //                                         style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500),
      //                                       ),
      //                                       Text(
      //                                         "${widget.catData["gender"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(top: 5),
      //                                   child: Row(
      //                                     children: [
      //                                       Text(
      //                                         "Spouse Name : ",
      //                                         style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500),
      //                                       ),
      //                                       Text(
      //                                         "${widget.catData["spouse_name"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(top: 5),
      //                                   child: Row(
      //                                     children: [
      //                                       Text(
      //                                         "Spouse Birth Date : ",
      //                                         style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500),
      //                                       ),
      //                                       Text(
      //                                         "${widget.catData["spouse_birth_date"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(
      //                                       top: 5, bottom: 15),
      //                                   child: Row(
      //                                     children: [
      //                                       Text(
      //                                         "Number Of Child : ",
      //                                         style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500),
      //                                       ),
      //                                       Text(
      //                                         "${widget.catData["number_of_child"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 16,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Column(
      //                         children: [
      //                           SizedBox(
      //                             height: 40,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(
      //                                 left: 5.0, right: 5),
      //                             child: Container(
      //                               // height: 450,
      //                               width: MediaQuery.of(context).size.width,
      //                               decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   border: Border.all(
      //                                       color: appPrimaryMaterialColor[50],
      //                                       width: 1),
      //                                   borderRadius: BorderRadius.all(
      //                                       Radius.circular(22.0)),
      //                                   boxShadow: [
      //                                     BoxShadow(
      //                                         color: appPrimaryMaterialColor
      //                                             .withOpacity(0.2),
      //                                         blurRadius: 2.0,
      //                                         spreadRadius: 2.0,
      //                                         offset: Offset(3.0, 5.0))
      //                                   ]),
      //                               child: Center(
      //                                 child: Padding(
      //                                   padding:
      //                                       const EdgeInsets.only(left: 20.0),
      //                                   child: Column(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.spaceAround,
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: <Widget>[
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 15.0),
      //                                         child: Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment.center,
      //                                           children: <Widget>[
      //                                             Icon(
      //                                               Icons.business,
      //                                               color:
      //                                                   appPrimaryMaterialColor,
      //                                             ),
      //                                             Padding(
      //                                               padding:
      //                                                   const EdgeInsets.only(
      //                                                       left: 5),
      //                                               child: Text(
      //                                                 'Business Info',
      //                                                 textAlign:
      //                                                     TextAlign.center,
      //                                                 style: TextStyle(
      //                                                     fontSize: 19,
      //                                                     fontWeight:
      //                                                         FontWeight.w600,
      //                                                     color: Colors.black),
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 18),
      //                                         child: Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment.start,
      //                                           children: [
      //                                             Text(
      //                                               "Company Name : ",
      //                                               style: TextStyle(
      //                                                   color: Colors.grey[500],
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500),
      //                                             ),
      //                                             FittedBox(
      //                                               child: Text(
      //                                                 "${widget.catData["company_name"]}",
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 15,
      //                                                     fontWeight:
      //                                                         FontWeight.w600),
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding:
      //                                             const EdgeInsets.only(top: 8),
      //                                         child: Row(
      //                                           children: [
      //                                             Text(
      //                                               "company_website : ",
      //                                               style: TextStyle(
      //                                                   color: Colors.grey[500],
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500),
      //                                             ),
      //                                             widget.catData[
      //                                                         "company_website"] !=
      //                                                     null
      //                                                 ? Text(
      //                                                     "${widget.catData["company_website"]}",
      //                                                     style: TextStyle(
      //                                                         color:
      //                                                             Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .w600),
      //                                                   )
      //                                                 : Text(
      //                                                     "-",
      //                                                     style: TextStyle(
      //                                                         color:
      //                                                             Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .w600),
      //                                                   ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding:
      //                                             const EdgeInsets.only(top: 8),
      //                                         child: Row(
      //                                           children: [
      //                                             Text(
      //                                               "Business Category : ",
      //                                               style: TextStyle(
      //                                                   color: Colors.grey[500],
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500),
      //                                             ),
      //                                             Text(
      //                                               widget.catData[
      //                                                           "business_category"] !=
      //                                                       null
      //                                                   ? "${widget.catData["business_category"]["categoryName"]}"
      //                                                   : "-",
      //                                               style: TextStyle(
      //                                                   color: Colors.black,
      //                                                   fontSize: 16,
      //                                                   fontWeight:
      //                                                       FontWeight.w600),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding:
      //                                             const EdgeInsets.only(top: 8),
      //                                         child: Text(
      //                                           "Address : ",
      //                                           style: TextStyle(
      //                                               color: Colors.grey[500],
      //                                               fontSize: 15,
      //                                               fontWeight:
      //                                                   FontWeight.w500),
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             left: 2.0, right: 12, top: 5),
      //                                         child: Text(
      //                                           "${widget.catData["address"]}",
      //                                           textAlign: TextAlign.justify,
      //                                           style: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 15,
      //                                               fontWeight:
      //                                                   FontWeight.w500),
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding:
      //                                             const EdgeInsets.only(top: 8),
      //                                         child: Text(
      //                                           "About Business : ",
      //                                           style: TextStyle(
      //                                               color: Colors.grey[500],
      //                                               fontSize: 15,
      //                                               fontWeight:
      //                                                   FontWeight.w500),
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 5.0,
      //                                             right: 12,
      //                                             bottom: 30),
      //                                         child: Text(
      //                                           "${widget.catData["about_business"]}",
      //                                           textAlign: TextAlign.justify,
      //                                           style: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 15,
      //                                               fontWeight:
      //                                                   FontWeight.w600),
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Container(
      //                         height: MediaQuery.of(context).size.height,
      //                         width: MediaQuery.of(context).size.width,
      //                         child: SingleChildScrollView(
      //                           child: Column(
      //                             mainAxisAlignment: MainAxisAlignment.start,
      //                             children: [
      //                               SizedBox(
      //                                 height: 35,
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 5, right: 5),
      //                                 child: Container(
      //                                   width:
      //                                       MediaQuery.of(context).size.width,
      //                                   decoration: BoxDecoration(
      //                                       color: Colors.white,
      //                                       border: Border.all(
      //                                           color:
      //                                               appPrimaryMaterialColor[50],
      //                                           width: 1),
      //                                       borderRadius: BorderRadius.all(
      //                                           Radius.circular(22.0)),
      //                                       boxShadow: [
      //                                         BoxShadow(
      //                                             color: appPrimaryMaterialColor
      //                                                 .withOpacity(0.2),
      //                                             blurRadius: 2.0,
      //                                             spreadRadius: 2.0,
      //                                             offset: Offset(3.0, 5.0))
      //                                       ]),
      //                                   child: Column(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.start,
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: <Widget>[
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 15.0),
      //                                         child: Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment.center,
      //                                           children: <Widget>[
      //                                             Icon(
      //                                               Icons.info,
      //                                               color:
      //                                                   appPrimaryMaterialColor,
      //                                             ),
      //                                             Padding(
      //                                               padding:
      //                                                   const EdgeInsets.only(
      //                                                       left: 5),
      //                                               child: Text(
      //                                                 'More Info',
      //                                                 textAlign:
      //                                                     TextAlign.center,
      //                                                 style: TextStyle(
      //                                                     fontSize: 17,
      //                                                     fontWeight:
      //                                                         FontWeight.w600,
      //                                                     color: Colors.black),
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 15.0, left: 20),
      //                                         child: Row(
      //                                           children: [
      //                                             Text(
      //                                               "Achievement : ",
      //                                               style: TextStyle(
      //                                                 color: Colors.grey[500],
      //                                                 fontSize: 15,
      //                                                 fontWeight:
      //                                                     FontWeight.w500,
      //                                               ),
      //                                             ),
      //                                             widget.catData[
      //                                                         "achievement"] !=
      //                                                     null
      //                                                 ? Text(
      //                                                     "${widget.catData["achievement"]}",
      //                                                     style: TextStyle(
      //                                                         color:
      //                                                             Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .bold,
      //                                                         letterSpacing: 1),
      //                                                   )
      //                                                 : Text(
      //                                                     "-",
      //                                                     style: TextStyle(
      //                                                       color: Colors.black,
      //                                                       fontSize: 15,
      //                                                       fontWeight:
      //                                                           FontWeight.w500,
      //                                                     ),
      //                                                   ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 8.0, left: 20),
      //                                         child: Row(
      //                                           children: [
      //                                             Text(
      //                                               "experience : ",
      //                                               style: TextStyle(
      //                                                   color: Colors.grey[500],
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500),
      //                                             ),
      //                                             Text(
      //                                               "${widget.catData["experience"]}",
      //                                               overflow:
      //                                                   TextOverflow.ellipsis,
      //                                               textAlign:
      //                                                   TextAlign.justify,
      //                                               style: TextStyle(
      //                                                   color: Colors.black,
      //                                                   fontSize: 14,
      //                                                   fontWeight:
      //                                                       FontWeight.w600),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       Padding(
      //                                         padding: const EdgeInsets.only(
      //                                             top: 8.0, left: 20),
      //                                         child: Row(
      //                                           children: [
      //                                             Text(
      //                                               "Mobile : ",
      //                                               style: TextStyle(
      //                                                 color: Colors.grey[500],
      //                                                 fontSize: 15,
      //                                                 fontWeight:
      //                                                     FontWeight.w500,
      //                                               ),
      //                                             ),
      //                                             Text(
      //                                               "${widget.catData["mobile"]}",
      //                                               style: TextStyle(
      //                                                   color: Colors.black,
      //                                                   fontSize: 16,
      //                                                   fontWeight:
      //                                                       FontWeight.bold,
      //                                                   letterSpacing: 1),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ),
      //                                       FittedBox(
      //                                         child: Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               top: 8.0, left: 20),
      //                                           child: Row(
      //                                             children: [
      //                                               Text(
      //                                                 "Email : ",
      //                                                 style: TextStyle(
      //                                                   color: Colors.grey[500],
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500,
      //                                                 ),
      //                                               ),
      //                                               Text(
      //                                                   "${widget.catData["email"]}",
      //                                                   style: TextStyle(
      //                                                       color: Colors.black,
      //                                                       fontSize: 15,
      //                                                       fontWeight:
      //                                                           FontWeight
      //                                                               .w500))
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       // Padding(
      //                                       //   padding: const EdgeInsets.only(
      //                                       //       left: 20.0, top: 8),
      //                                       //   child: Text("Network Type : ",
      //                                       //       style: TextStyle(
      //                                       //           fontSize: 15,
      //                                       //           color: Colors.grey[500],
      //                                       //           fontWeight:
      //                                       //               FontWeight.w500)),
      //                                       // ),
      //                                       // Padding(
      //                                       //   padding: const EdgeInsets.only(
      //                                       //       left: 20,
      //                                       //       right: 20,
      //                                       //       top: 5,
      //                                       //       bottom: 10),
      //                                       //   child: Container(
      //                                       //       height: 75,
      //                                       //       width: MediaQuery.of(context)
      //                                       //           .size
      //                                       //           .width,
      //                                       //       decoration: BoxDecoration(
      //                                       //           color: Colors.white,
      //                                       //           border: Border.all(
      //                                       //               color:
      //                                       //                   appPrimaryMaterialColor[
      //                                       //                       50],
      //                                       //               width: 1),
      //                                       //           borderRadius:
      //                                       //               BorderRadius.all(
      //                                       //                   Radius.circular(
      //                                       //                       22.0))),
      //                                       //       child:
      //                                       //           widget.catData[
      //                                       //                       "memberOf"] ==
      //                                       //                   null
      //                                       //               ? Center(
      //                                       //                   child: Text(
      //                                       //                       "No Member"))
      //                                       //               : SizedBox(
      //                                       //                   child: widget
      //                                       //                               .catData[
      //                                       //                                   "memberOf"]
      //                                       //                               .length >
      //                                       //                           0
      //                                       //                       ? ListView.builder(
      //                                       //                           physics: BouncingScrollPhysics(),
      //                                       //                           scrollDirection: Axis.horizontal,
      //                                       //                           itemCount: widget.catData["memberOf"].length,
      //                                       //                           itemBuilder: (BuildContext context, int index) {
      //                                       //                             return Padding(
      //                                       //                               padding: const EdgeInsets.only(
      //                                       //                                   left: 5.0,
      //                                       //                                   bottom: 3),
      //                                       //                               child:
      //                                       //                                   Container(
      //                                       //                                 child:
      //                                       //                                     Column(
      //                                       //                                   children: [
      //                                       //                                     Padding(
      //                                       //                                         padding: const EdgeInsets.only(top: 15.0, bottom: 5, left: 5),
      //                                       //                                         child: Image.network(
      //                                       //                                           "${widget.catData["memberOf"][index]["logo"]}",
      //                                       //                                           width: 45,
      //                                       //                                         )),
      //                                       //                                     Text("${widget.catData["memberOf"][index]["memberShipName"]}"),
      //                                       //                                   ],
      //                                       //                                 ),
      //                                       //                               ),
      //                                       //                             );
      //                                       //                           })
      //                                       //                       : SizedBox(),
      //                                       //                 )),
      //                                       // ),
      //                                       SizedBox(
      //                                         height: 20,
      //                                       )
      //                                       // Padding(
      //                                       //   padding: const EdgeInsets.only(
      //                                       //       left: 20.0, top: 8),
      //                                       //   child: Text("Social Media : ",
      //                                       //       style: TextStyle(
      //                                       //           fontSize: 15,
      //                                       //           color: Colors.grey[500],
      //                                       //           fontWeight:
      //                                       //               FontWeight.w500)),
      //                                       // ),
      //                                       // Padding(
      //                                       //   padding: const EdgeInsets.only(
      //                                       //       top: 8,
      //                                       //       left: 8.0,
      //                                       //       right: 8,
      //                                       //       bottom: 30),
      //                                       //   child: Container(
      //                                       //     height: 55,
      //                                       //     decoration: BoxDecoration(
      //                                       //         color: Colors.white,
      //                                       //         border: Border.all(
      //                                       //             color:
      //                                       //                 appPrimaryMaterialColor[
      //                                       //                     50],
      //                                       //             width: 1),
      //                                       //         borderRadius:
      //                                       //             BorderRadius.all(
      //                                       //                 Radius.circular(
      //                                       //                     22.0))),
      //                                       //     child: SocialMediaComponent(
      //                                       //       facebook: widget
      //                                       //           .catData["faceBook"],
      //                                       //       instagram: widget
      //                                       //           .catData["instagram"],
      //                                       //       linkedIn: widget
      //                                       //           .catData["linkedIn"],
      //                                       //       twitter:
      //                                       //           widget.catData["twitter"],
      //                                       //       whatsapp: widget
      //                                       //           .catData["whatsApp"],
      //                                       //       youtube:
      //                                       //           widget.catData["youTube"],
      //                                       //     ),
      //                                       //   ),
      //                                       // ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           /*Stack(
      //                         children: <Widget>[
      //                       Column(
      //                         children: <Widget>[
      //                           //Make Design
      //                           Container(
      //                             margin: EdgeInsets.only(top: 10),
      //                             child: Column(
      //                               children: <Widget>[
      //                                 Card(
      //                                   margin: EdgeInsets.all(10),
      //                                   elevation: 3,
      //                                   child: Container(
      //                                     //padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      //                                     child: Padding(
      //                                       padding: const EdgeInsets.only(
      //                                           left: 10, right: 20, bottom: 20),
      //                                       child: Column(
      //                                         children: <Widget>[
      //                                           Container(
      //                                             height: 50,
      //                                             width: MediaQuery.of(context)
      //                                                 .size
      //                                                 .width,
      //                                             child: Row(
      //                                               crossAxisAlignment:
      //                                                   CrossAxisAlignment.center,
      //                                               mainAxisAlignment:
      //                                                   MainAxisAlignment
      //                                                       .spaceBetween,
      //                                               children: <Widget>[
      //                                                 Row(
      //                                                   children: <Widget>[
      //                                                     Icon(
      //                                                       Icons.business,
      //                                                       color:
      //                                                           appPrimaryMaterialColor,
      //                                                     ),
      //                                                     Padding(
      //                                                       padding:
      //                                                           const EdgeInsets
      //                                                                   .only(
      //                                                               left: 5),
      //                                                       child: Text(
      //                                                         'Business Info',
      //                                                         textAlign: TextAlign
      //                                                             .center,
      //                                                         style: TextStyle(
      //                                                             fontSize: 19,
      //                                                             fontWeight:
      //                                                                 FontWeight
      //                                                                     .w600,
      //                                                             color: Colors
      //                                                                 .black),
      //                                                       ),
      //                                                     ),
      //                                                   ],
      //                                                 ),
      //                                               ],
      //                                             ),
      //                                           ),
      //                                           Divider(
      //                                             color: Colors.grey,
      //                                           ),
      //                                           TextFormField(
      //                                             //   controller: edtCmpName,
      //                                             scrollPadding:
      //                                                 EdgeInsets.all(0),
      //                                             decoration: InputDecoration(
      //                                                 labelText: "Company",
      //                                                 labelStyle: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 16,
      //                                                     fontWeight:
      //                                                         FontWeight.w600),
      //                                                 hintText: "Company"),
      //                                             minLines: 1,
      //                                             maxLines: 4,
      //                                             keyboardType:
      //                                                 TextInputType.multiline,
      //                                             style: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 15),
      //                                           ),
      //                                           TextFormField(
      //                                             scrollPadding:
      //                                                 EdgeInsets.all(0),
      //                                             decoration: InputDecoration(
      //                                                 labelText:
      //                                                     "Business Category:",
      //                                                 labelStyle: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 16,
      //                                                     fontWeight:
      //                                                         FontWeight.w600),
      //                                                 hintText:
      //                                                     "Business Category"),
      //                                             keyboardType:
      //                                                 TextInputType.multiline,
      //                                             style: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 15),
      //                                           ),
      //                                           TextFormField(
      //                                             scrollPadding:
      //                                                 EdgeInsets.all(0),
      //                                             decoration: InputDecoration(
      //                                                 labelText: "Address",
      //                                                 labelStyle: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 16,
      //                                                     fontWeight:
      //                                                         FontWeight.w600),
      //                                                 hintText: "Address"),
      //                                             // enabled: isBusinessEditable,
      //                                             minLines: 1,
      //                                             maxLines: 4,
      //                                             keyboardType:
      //                                                 TextInputType.multiline,
      //                                             style: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 15),
      //                                           ),
      //                                           TextFormField(
      //                                             //  controller: edtBusinessAbout,
      //                                             scrollPadding:
      //                                                 EdgeInsets.all(0),
      //                                             decoration: InputDecoration(
      //                                                 labelText: "About Business",
      //                                                 labelStyle: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 16,
      //                                                     fontWeight:
      //                                                         FontWeight.w600),
      //                                                 hintText: "About Business"),
      //                                             //  enabled: isBusinessEditable,
      //                                             minLines: 1,
      //                                             maxLines: 4,
      //                                             keyboardType:
      //                                                 TextInputType.multiline,
      //                                             style: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 15),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                         ],
      //                       ),*/
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   SizedBox(
      //                     height: 40,
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20.0, right: 20),
      //                     child: Container(
      //                       // height: 450,
      //                       width: MediaQuery.of(context).size.width,
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           border: Border.all(
      //                               color: appPrimaryMaterialColor[50],
      //                               width: 1),
      //                           borderRadius:
      //                               BorderRadius.all(Radius.circular(22.0)),
      //                           boxShadow: [
      //                             BoxShadow(
      //                                 color: appPrimaryMaterialColor
      //                                     .withOpacity(0.2),
      //                                 blurRadius: 2.0,
      //                                 spreadRadius: 2.0,
      //                                 offset: Offset(3.0, 5.0))
      //                           ]),
      //                       child: Center(
      //                         child: Padding(
      //                           padding: const EdgeInsets.only(left: 20.0),
      //                           child: Column(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceAround,
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: <Widget>[
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 15.0),
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.center,
      //                                   children: <Widget>[
      //                                     Icon(
      //                                       Icons.business,
      //                                       color: appPrimaryMaterialColor,
      //                                     ),
      //                                     Padding(
      //                                       padding:
      //                                           const EdgeInsets.only(left: 5),
      //                                       child: Text(
      //                                         'Business Info',
      //                                         textAlign: TextAlign.center,
      //                                         style: TextStyle(
      //                                             fontSize: 19,
      //                                             fontWeight: FontWeight.w600,
      //                                             color: Colors.black),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 18),
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.start,
      //                                   children: [
      //                                     Text(
      //                                       "Company Name : ",
      //                                       style: TextStyle(
      //                                           color: Colors.grey[500],
      //                                           fontSize: 15,
      //                                           fontWeight: FontWeight.w500),
      //                                     ),
      //                                     FittedBox(
      //                                       child: Text(
      //                                         "${widget.catData["company_name"]}",
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w600),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 8),
      //                                 child: Row(
      //                                   children: [
      //                                     Text(
      //                                       "company_website : ",
      //                                       style: TextStyle(
      //                                           color: Colors.grey[500],
      //                                           fontSize: 15,
      //                                           fontWeight: FontWeight.w500),
      //                                     ),
      //                                     widget.catData["company_website"] !=
      //                                             null
      //                                         ? Text(
      //                                             "${widget.catData["company_website"]}",
      //                                             style: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 16,
      //                                                 fontWeight:
      //                                                     FontWeight.w600),
      //                                           )
      //                                         : Text(
      //                                             "-",
      //                                             style: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 16,
      //                                                 fontWeight:
      //                                                     FontWeight.w600),
      //                                           ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 8),
      //                                 child: Row(
      //                                   children: [
      //                                     Text(
      //                                       "Business Category : ",
      //                                       style: TextStyle(
      //                                           color: Colors.grey[500],
      //                                           fontSize: 15,
      //                                           fontWeight: FontWeight.w500),
      //                                     ),
      //                                     Text(
      //                                       widget.catData[
      //                                                   "business_category"] !=
      //                                               null
      //                                           ? "${widget.catData["business_category"]["categoryName"]}"
      //                                           : "-",
      //                                       style: TextStyle(
      //                                           color: Colors.black,
      //                                           fontSize: 16,
      //                                           fontWeight: FontWeight.w600),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 8),
      //                                 child: Text(
      //                                   "Address : ",
      //                                   style: TextStyle(
      //                                       color: Colors.grey[500],
      //                                       fontSize: 15,
      //                                       fontWeight: FontWeight.w500),
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 2.0, right: 12, top: 5),
      //                                 child: Text(
      //                                   "${widget.catData["address"]}",
      //                                   textAlign: TextAlign.justify,
      //                                   style: TextStyle(
      //                                       color: Colors.black,
      //                                       fontSize: 15,
      //                                       fontWeight: FontWeight.w500),
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(top: 8),
      //                                 child: Text(
      //                                   "About Business : ",
      //                                   style: TextStyle(
      //                                       color: Colors.grey[500],
      //                                       fontSize: 15,
      //                                       fontWeight: FontWeight.w500),
      //                                 ),
      //                               ),
      //                               Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     top: 5.0, right: 12, bottom: 30),
      //                                 child: Text(
      //                                   "${widget.catData["about_business"]}",
      //                                   textAlign: TextAlign.justify,
      //                                   style: TextStyle(
      //                                       color: Colors.black,
      //                                       fontSize: 15,
      //                                       fontWeight: FontWeight.w600),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     height: MediaQuery.of(context).size.height,
      //                     width: MediaQuery.of(context).size.width,
      //                     child: SingleChildScrollView(
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: [
      //                           SizedBox(
      //                             height: 35,
      //                           ),
      //                           Padding(
      //                             padding: const EdgeInsets.only(
      //                                 left: 20, right: 20),
      //                             child: Container(
      //                               width: MediaQuery.of(context).size.width,
      //                               decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   border: Border.all(
      //                                       color: appPrimaryMaterialColor[50],
      //                                       width: 1),
      //                                   borderRadius: BorderRadius.all(
      //                                       Radius.circular(22.0)),
      //                                   boxShadow: [
      //                                     BoxShadow(
      //                                         color: appPrimaryMaterialColor
      //                                             .withOpacity(0.2),
      //                                         blurRadius: 2.0,
      //                                         spreadRadius: 2.0,
      //                                         offset: Offset(3.0, 5.0))
      //                                   ]),
      //                               child: Column(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.start,
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: <Widget>[
      //                                   Padding(
      //                                     padding:
      //                                         const EdgeInsets.only(top: 15.0),
      //                                     child: Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.center,
      //                                       children: <Widget>[
      //                                         Icon(
      //                                           Icons.info,
      //                                           color: appPrimaryMaterialColor,
      //                                         ),
      //                                         Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               left: 5),
      //                                           child: Text(
      //                                             'More Info',
      //                                             textAlign: TextAlign.center,
      //                                             style: TextStyle(
      //                                                 fontSize: 17,
      //                                                 fontWeight:
      //                                                     FontWeight.w600,
      //                                                 color: Colors.black),
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   Padding(
      //                                     padding: const EdgeInsets.only(
      //                                         top: 15.0, left: 20),
      //                                     child: Row(
      //                                       children: [
      //                                         Text(
      //                                           "Achievement : ",
      //                                           style: TextStyle(
      //                                             color: Colors.grey[500],
      //                                             fontSize: 15,
      //                                             fontWeight: FontWeight.w500,
      //                                           ),
      //                                         ),
      //                                         widget.catData["achievement"] !=
      //                                                 null
      //                                             ? Text(
      //                                                 "${widget.catData["achievement"]}",
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 16,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     letterSpacing: 1),
      //                                               )
      //                                             : Text(
      //                                                 "-",
      //                                                 style: TextStyle(
      //                                                   color: Colors.black,
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500,
      //                                                 ),
      //                                               ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   Padding(
      //                                     padding: const EdgeInsets.only(
      //                                         top: 8.0, left: 20),
      //                                     child: Row(
      //                                       children: [
      //                                         Text(
      //                                           "experience : ",
      //                                           style: TextStyle(
      //                                               color: Colors.grey[500],
      //                                               fontSize: 15,
      //                                               fontWeight:
      //                                                   FontWeight.w500),
      //                                         ),
      //                                         Text(
      //                                           "${widget.catData["experience"]}",
      //                                           overflow: TextOverflow.ellipsis,
      //                                           textAlign: TextAlign.justify,
      //                                           style: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 14,
      //                                               fontWeight:
      //                                                   FontWeight.w600),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   isMember == "false"
      //                                       ? Container()
      //                                       : Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               top: 8.0, left: 20),
      //                                           child: Row(
      //                                             children: [
      //                                               Text(
      //                                                 "Mobile : ",
      //                                                 style: TextStyle(
      //                                                   color: Colors.grey[500],
      //                                                   fontSize: 15,
      //                                                   fontWeight:
      //                                                       FontWeight.w500,
      //                                                 ),
      //                                               ),
      //                                               Text(
      //                                                 "${widget.catData["mobile"]}",
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 16,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     letterSpacing: 1),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         ),
      //                                   isMember == "false"
      //                                       ? Container()
      //                                       : FittedBox(
      //                                           child: Padding(
      //                                             padding:
      //                                                 const EdgeInsets.only(
      //                                                     top: 8.0, left: 20),
      //                                             child: Row(
      //                                               children: [
      //                                                 Text(
      //                                                   "Email : ",
      //                                                   style: TextStyle(
      //                                                     color:
      //                                                         Colors.grey[500],
      //                                                     fontSize: 15,
      //                                                     fontWeight:
      //                                                         FontWeight.w500,
      //                                                   ),
      //                                                 ),
      //                                                 Text(
      //                                                     "${widget.catData["email"]}",
      //                                                     style: TextStyle(
      //                                                         color:
      //                                                             Colors.black,
      //                                                         fontSize: 15,
      //                                                         fontWeight:
      //                                                             FontWeight
      //                                                                 .w500))
      //                                               ],
      //                                             ),
      //                                           ),
      //                                         ),
      //                                   Padding(
      //                                     padding: const EdgeInsets.only(
      //                                         left: 20.0, top: 8),
      //                                     child: Text("Network Type : ",
      //                                         style: TextStyle(
      //                                             fontSize: 15,
      //                                             color: Colors.grey[500],
      //                                             fontWeight: FontWeight.w500)),
      //                                   ),
      //                                   Padding(
      //                                     padding: const EdgeInsets.only(
      //                                         left: 20,
      //                                         right: 20,
      //                                         top: 5,
      //                                         bottom: 10),
      //                                     child: Container(
      //                                         height: 75,
      //                                         width: MediaQuery.of(context)
      //                                             .size
      //                                             .width,
      //                                         decoration: BoxDecoration(
      //                                             color: Colors.white,
      //                                             border: Border.all(
      //                                                 color:
      //                                                     appPrimaryMaterialColor[
      //                                                         50],
      //                                                 width: 1),
      //                                             borderRadius:
      //                                                 BorderRadius.all(
      //                                                     Radius.circular(
      //                                                         22.0))),
      //                                         child:
      //                                             widget.catData["memberOf"] ==
      //                                                     null
      //                                                 ? Center(
      //                                                     child:
      //                                                         Text("No Member"))
      //                                                 : SizedBox(
      //                                                     child: widget
      //                                                                 .catData[
      //                                                                     "memberOf"]
      //                                                                 .length >
      //                                                             0
      //                                                         ? ListView
      //                                                             .builder(
      //                                                                 physics:
      //                                                                     BouncingScrollPhysics(),
      //                                                                 scrollDirection:
      //                                                                     Axis
      //                                                                         .horizontal,
      //                                                                 itemCount: widget
      //                                                                     .catData[
      //                                                                         "memberOf"]
      //                                                                     .length,
      //                                                                 itemBuilder:
      //                                                                     (BuildContext context,
      //                                                                         int index) {
      //                                                                   return Padding(
      //                                                                     padding: const EdgeInsets.only(
      //                                                                         left: 5.0,
      //                                                                         bottom: 3),
      //                                                                     child:
      //                                                                         Container(
      //                                                                       child:
      //                                                                           Column(
      //                                                                         children: [
      //                                                                           Padding(
      //                                                                               padding: const EdgeInsets.only(top: 15.0, bottom: 5, left: 5),
      //                                                                               child: Image.network(
      //                                                                                 "${widget.catData["memberOf"][index]["logo"]}",
      //                                                                                 width: 45,
      //                                                                               )),
      //                                                                           Text("${widget.catData["memberOf"][index]["memberShipName"]}"),
      //                                                                         ],
      //                                                                       ),
      //                                                                     ),
      //                                                                   );
      //                                                                 })
      //                                                         : SizedBox(),
      //                                                   )),
      //                                   ),
      //                                   isMember == "false"
      //                                       ? Container()
      //                                       : Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               left: 20.0, top: 8),
      //                                           child: Text("Social Media : ",
      //                                               style: TextStyle(
      //                                                   fontSize: 15,
      //                                                   color: Colors.grey[500],
      //                                                   fontWeight:
      //                                                       FontWeight.w500)),
      //                                         ),
      //                                   isMember == "false"
      //                                       ? Container()
      //                                       : Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               top: 8,
      //                                               left: 8.0,
      //                                               right: 8,
      //                                               bottom: 30),
      //                                           child: Container(
      //                                             height: 55,
      //                                             decoration: BoxDecoration(
      //                                                 color: Colors.white,
      //                                                 border: Border.all(
      //                                                     color:
      //                                                         appPrimaryMaterialColor[
      //                                                             50],
      //                                                     width: 1),
      //                                                 borderRadius:
      //                                                     BorderRadius.all(
      //                                                         Radius.circular(
      //                                                             22.0))),
      //                                             child: SocialMediaComponent(
      //                                               facebook: widget
      //                                                   .catData["faceBook"],
      //                                               instagram: widget
      //                                                   .catData["instagram"],
      //                                               linkedIn: widget
      //                                                   .catData["linkedIn"],
      //                                               twitter: widget
      //                                                   .catData["twitter"],
      //                                               whatsapp: widget
      //                                                   .catData["whatsApp"],
      //                                               youtube: widget
      //                                                   .catData["youTube"],
      //                                             ),
      //                                           ),
      //                                         ),
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       /*Stack(
      //                         children: <Widget>[
      //                           Column(
      //                             children: <Widget>[
      //                               //Make Design
      //                               Container(
      //                                 margin: EdgeInsets.only(top: 10),
      //                                 child: Column(
      //                                   children: <Widget>[
      //                                     Card(
      //                                       margin: EdgeInsets.all(10),
      //                                       elevation: 3,
      //                                       child: Container(
      //                                         //padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      //                                         child: Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               left: 10, right: 20, bottom: 20),
      //                                           child: Column(
      //                                             children: <Widget>[
      //                                               Container(
      //                                                 height: 50,
      //                                                 width: MediaQuery.of(context)
      //                                                     .size
      //                                                     .width,
      //                                                 child: Row(
      //                                                   crossAxisAlignment:
      //                                                       CrossAxisAlignment.center,
      //                                                   mainAxisAlignment:
      //                                                       MainAxisAlignment
      //                                                           .spaceBetween,
      //                                                   children: <Widget>[
      //                                                     Row(
      //                                                       children: <Widget>[
      //                                                         Icon(
      //                                                           Icons.business,
      //                                                           color:
      //                                                               appPrimaryMaterialColor,
      //                                                         ),
      //                                                         Padding(
      //                                                           padding:
      //                                                               const EdgeInsets
      //                                                                       .only(
      //                                                                   left: 5),
      //                                                           child: Text(
      //                                                             'Business Info',
      //                                                             textAlign: TextAlign
      //                                                                 .center,
      //                                                             style: TextStyle(
      //                                                                 fontSize: 19,
      //                                                                 fontWeight:
      //                                                                     FontWeight
      //                                                                         .w600,
      //                                                                 color: Colors
      //                                                                     .black),
      //                                                           ),
      //                                                         ),
      //                                                       ],
      //                                                     ),
      //                                                   ],
      //                                                 ),
      //                                               ),
      //                                               Divider(
      //                                                 color: Colors.grey,
      //                                               ),
      //                                               TextFormField(
      //                                                 //   controller: edtCmpName,
      //                                                 scrollPadding:
      //                                                     EdgeInsets.all(0),
      //                                                 decoration: InputDecoration(
      //                                                     labelText: "Company",
      //                                                     labelStyle: TextStyle(
      //                                                         color: Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight.w600),
      //                                                     hintText: "Company"),
      //                                                 minLines: 1,
      //                                                 maxLines: 4,
      //                                                 keyboardType:
      //                                                     TextInputType.multiline,
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 15),
      //                                               ),
      //                                               TextFormField(
      //                                                 scrollPadding:
      //                                                     EdgeInsets.all(0),
      //                                                 decoration: InputDecoration(
      //                                                     labelText:
      //                                                         "Business Category:",
      //                                                     labelStyle: TextStyle(
      //                                                         color: Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight.w600),
      //                                                     hintText:
      //                                                         "Business Category"),
      //                                                 keyboardType:
      //                                                     TextInputType.multiline,
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 15),
      //                                               ),
      //                                               TextFormField(
      //                                                 scrollPadding:
      //                                                     EdgeInsets.all(0),
      //                                                 decoration: InputDecoration(
      //                                                     labelText: "Address",
      //                                                     labelStyle: TextStyle(
      //                                                         color: Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight.w600),
      //                                                     hintText: "Address"),
      //                                                 // enabled: isBusinessEditable,
      //                                                 minLines: 1,
      //                                                 maxLines: 4,
      //                                                 keyboardType:
      //                                                     TextInputType.multiline,
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 15),
      //                                               ),
      //                                               TextFormField(
      //                                                 //  controller: edtBusinessAbout,
      //                                                 scrollPadding:
      //                                                     EdgeInsets.all(0),
      //                                                 decoration: InputDecoration(
      //                                                     labelText: "About Business",
      //                                                     labelStyle: TextStyle(
      //                                                         color: Colors.black,
      //                                                         fontSize: 16,
      //                                                         fontWeight:
      //                                                             FontWeight.w600),
      //                                                     hintText: "About Business"),
      //                                                 //  enabled: isBusinessEditable,
      //                                                 minLines: 1,
      //                                                 maxLines: 4,
      //                                                 keyboardType:
      //                                                     TextInputType.multiline,
      //                                                 style: TextStyle(
      //                                                     color: Colors.black,
      //                                                     fontSize: 15),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ],
      //                       ),*/
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             /* Container(
      //               height: MediaQuery.of(context).size.height,
      //               width: MediaQuery.of(context).size.width,
      //               child: SingleChildScrollView(
      //                 child: Stack(
      //                   children: <Widget>[
      //                     Container(
      //                       margin: EdgeInsets.only(top: 10),
      //                       child: Column(
      //                         children: <Widget>[
      //                           Card(
      //                             margin: EdgeInsets.all(10),
      //                             elevation: 3,
      //                             child: Container(
      //                               //padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      //                               child: Padding(
      //                                 padding: const EdgeInsets.only(
      //                                     left: 10, right: 20, bottom: 20),
      //                                 child: Column(
      //                                   children: <Widget>[
      //                                     Container(
      //                                       height: 50,
      //                                       width: MediaQuery.of(context)
      //                                           .size
      //                                           .width,
      //                                       child: Row(
      //                                         crossAxisAlignment:
      //                                             CrossAxisAlignment.center,
      //                                         mainAxisAlignment:
      //                                             MainAxisAlignment
      //                                                 .spaceBetween,
      //                                         children: <Widget>[
      //                                           Row(
      //                                             children: <Widget>[
      //                                               Icon(
      //                                                 Icons.info,
      //                                                 color:
      //                                                     appPrimaryMaterialColor,
      //                                               ),
      //                                               Padding(
      //                                                 padding:
      //                                                     const EdgeInsets.only(
      //                                                         left: 5),
      //                                                 child: Text(
      //                                                   'More Info',
      //                                                   textAlign:
      //                                                       TextAlign.center,
      //                                                   style: TextStyle(
      //                                                       fontSize: 17,
      //                                                       fontWeight:
      //                                                           FontWeight.w600,
      //                                                       color:
      //                                                           Colors.black),
      //                                                 ),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                     Divider(
      //                                       color: Colors.grey,
      //                                     ),
      //                                     */ /*TextFormField(
      //                                         controller: edtTestimonial,
      //                                         scrollPadding:
      //                                             EdgeInsets.all(0),
      //                                         decoration: InputDecoration(
      //                                             labelText: "Testimonial",
      //                                             labelStyle: TextStyle(
      //                                                 color: Colors.black,
      //                                                 fontSize: 16,
      //                                                 fontWeight:
      //                                                     FontWeight.w600),
      //                                             hintText: "Testimonial"),
      //                                         enabled: isMoreEditable,
      //                                         minLines: 1,
      //                                         maxLines: 4,
      //                                         keyboardType:
      //                                             TextInputType.multiline,
      //                                         style: TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 15),
      //                                       ),*/ /*
      //                                     TextFormField(
      //                                       //controller: edtAchievement,
      //                                       scrollPadding: EdgeInsets.all(0),
      //                                       decoration: InputDecoration(
      //                                           labelText: "Achievement",
      //                                           labelStyle: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 16,
      //                                               fontWeight:
      //                                                   FontWeight.w600),
      //                                           hintText: "Achievement"),
      //                                       // enabled: isMoreEditable,
      //                                       minLines: 1,
      //                                       maxLines: 4,
      //                                       keyboardType:
      //                                           TextInputType.multiline,
      //                                       style: TextStyle(
      //                                           color: Colors.black,
      //                                           fontSize: 15),
      //                                     ),
      //                                     TextFormField(
      //                                       // controller: edtExperienceOfWork,
      //                                       scrollPadding: EdgeInsets.all(0),
      //                                       decoration: InputDecoration(
      //                                           labelText: "Experience Of Work",
      //                                           labelStyle: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 16,
      //                                               fontWeight:
      //                                                   FontWeight.w600),
      //                                           hintText: "Experience Of Work"),
      //                                       //enabled: isMoreEditable,
      //                                       minLines: 1,
      //                                       maxLines: 4,
      //                                       keyboardType:
      //                                           TextInputType.multiline,
      //                                       style: TextStyle(
      //                                           color: Colors.black,
      //                                           fontSize: 15),
      //                                     ),
      //                                     TextFormField(
      //                                       //controller: edtAskForPeople,
      //                                       scrollPadding: EdgeInsets.all(0),
      //                                       decoration: InputDecoration(
      //                                           labelText: "Ask For People",
      //                                           labelStyle: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 16,
      //                                               fontWeight:
      //                                                   FontWeight.w600),
      //                                           hintText: "Ask For People"),
      //                                       //  enabled: isMoreEditable,
      //                                       minLines: 1,
      //                                       maxLines: 4,
      //                                       keyboardType:
      //                                           TextInputType.multiline,
      //                                       style: TextStyle(
      //                                           color: Colors.black,
      //                                           fontSize: 15),
      //                                     ),
      //                                     TextFormField(
      //                                       //controller: edtIntroducer,
      //                                       scrollPadding: EdgeInsets.all(0),
      //                                       decoration: InputDecoration(
      //                                           labelText: "Introducer",
      //                                           labelStyle: TextStyle(
      //                                               color: Colors.black,
      //                                               fontSize: 16,
      //                                               fontWeight:
      //                                                   FontWeight.w600),
      //                                           hintText: "Introducer"),
      //                                       // enabled: isMoreEditable,
      //                                       minLines: 1,
      //                                       maxLines: 4,
      //                                       keyboardType:
      //                                           TextInputType.multiline,
      //                                       style: TextStyle(
      //                                           color: Colors.black,
      //                                           fontSize: 15),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),*/
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      /*SingleChildScrollView(
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
                        NetworkImage("${widget.catData["img"]}"),
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
                        "${widget.catData["name"]}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      widget.catData["business_category"] == null
                          ? Text("")
                          : Text(
                              "${widget.catData["business_category"]["categoryName"]}",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                      Text(
//                                          "Future Group Info Soft",
                          "${widget.catData["company_name"]}",
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
                          facebook: widget.catData["faceBook"],
                          instagram: widget.catData["instagram"],
                          linkedIn: widget.catData["linkedIn"],
                          twitter: widget.catData["twitter"],
                          whatsapp: widget.catData["whatsApp"],
                          mail: widget.catData["email"],
                        ),
                      ],
                    )),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Member Type",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                              SizedBox(
                                height: 70,
                                width: MediaQuery.of(context).size.width,
                                child: widget.catData["memberOf"].length >
                                        0
                                    ? ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget
                                            .catData["memberOf"].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, bottom: 3),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0,
                                                              bottom: 5,
                                                              left: 5),
                                                      child: Image.network(
                                                        "${widget.catData["memberOf"][index]["logo"]}",
                                                        width: 45,
                                                      )),
                                                  Text(
                                                      "${widget.catData["memberOf"][index]["memberShipName"]}"),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    : SizedBox(),
                              )
                            ],
                          ),
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
                              "${widget.catData["mobile"]}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                            Text("${widget.catData["email"]}",
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
                  "Share my details",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      fontSize: 21),
                )),
              ),
              SizedBox(
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
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}
