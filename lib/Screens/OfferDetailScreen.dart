import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';

class OfferDetailScreen extends StatefulWidget {
  var offerData;

  OfferDetailScreen({this.offerData});

  @override
  _OfferDetailScreenState createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  String exDate;
  var date;
  var date2 = DateTime.now();
  var difference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("Expiry Date :${widget.offerData["offerExpire"]}");
    funDate();
  }

  funDate() {
    //
    // date = exDate.split('-');
    // int day = int.parse("${date[0]}");
    // int month = int.parse("${date[1]}");
    // int year = int.parse("${date[2]}");
    // var expiryDate = DateTime(year, month, day);
    // print("expiryDate-------------------->${expiryDate}");
    // setState(() {
    //   difference = expiryDate.difference(date2).inDays;
    // });
    // print("difference-------------------->${difference}");
    //
    // setState(() {
    //   exDate = "${widget.offerData["offerExpire"]}";
    // });
    setState(() {
      exDate = "${widget.offerData["offerExpire"]}";
    });
    if (exDate != "") {
      log("==========================");

      date = exDate.split('/');
      int year = int.parse("${date[0]}");
      int month = int.parse("${date[1]}");
      int day = int.parse("${date[2]}");
      var expiryDate = DateTime(year, month, day);
      print("expiryDate-------------------->${expiryDate}");
      setState(() {
        difference = expiryDate.difference(date2).inDays;
      });
    }

    print("difference-------------------->${difference}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Offers Details",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 18,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(context,MaterialPageRoute(builder:(context) =>Networking()));
              },
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "${widget.offerData["bannerImage"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SocialMediaComponent(
              facebook: widget.offerData["faceBook"],
              instagram: widget.offerData["instagram"],
              linkedIn: widget.offerData["linkedIn"],
              twitter: widget.offerData["twitter"],
              whatsapp: widget.offerData["whatsApp"],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Social Media links",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Offer Created By",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 250.0),
              child: Container(
                color: appPrimaryMaterialColor,
                height: 3,
              ),
            ),
            SizedBox(
              height: 15,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "${widget.offerData["bannerImage"]}",
                              fit: BoxFit.cover,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          "${widget.offerData["title"]}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: appPrimaryMaterialColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      )
                    ],
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            exDate == ""
                ? Container()
                : Text(
                    "Offer Expires On",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
            exDate == ""
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 250.0),
                    child: Container(
                      height: 3,
                      width: 40,
                      color: appPrimaryMaterialColor,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            exDate == ""
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 35,
                            color: Color(0xff367a98),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 45,
                              child: Card(
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                      "${widget.offerData["offerExpire"]}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      exDate == ""
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                height: 45,
                                child: Card(
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        //"${widget.offerData["daysRemain"]}" + " Days to Go",
                                        difference <= 0
                                            ? "Offer Expired"
                                            : "${difference}" + " Days to Go",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18)),
                                  )),
                                ),
                              ),
                            ),
                    ],
                  ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Description",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 250.0),
              child: Container(
                height: 3,
                width: 40,
                color: appPrimaryMaterialColor,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${widget.offerData["details"]}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.black, fontSize: 14, letterSpacing: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
