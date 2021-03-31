import 'package:flutter/material.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

class OfferDetail extends StatefulWidget {
  // final OfferClass offerClass;
  //
  // const OfferDetail({Key key, this.offerClass}) : super(key: key);
  var offerData, offerdate;
  OfferDetail({this.offerData, this.offerdate});

  @override
  _OfferDetailState createState() => _OfferDetailState();
}

class _OfferDetailState extends State<OfferDetail> {
  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Offer Detail'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        //margin: EdgeInsets.only(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (widget.offerData["imagecode"] != null &&
                    widget.offerData["imagecode"] != "")
                ? Image.network(widget.offerData["imagecode"],
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill)
                : Image.asset("images/nooffer.jpg",
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    fit: BoxFit.fill),
            Card(
              elevation: 3,
              margin: EdgeInsets.all(0),
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(widget.offerData["title"],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cnst.appcolor)),
                          ),
                          Row(
                            children: <Widget>[
                              Text("Available till :",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600])),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(widget.offerdate,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: cnst.appcolor)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    /*MaterialButton(
                            onPressed: () {
                              //Navigator.pushNamed(context, "/OfferInterestedMembers");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferInterestedMembers(
                                          OfferId: widget.offerClass.Id)));
                            },
                            padding: EdgeInsets.all(5),
                            color: cnst.buttoncolor,
                            child: Column(
                              children: <Widget>[
                                Text("500",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                Text("Interested",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          )*/
                  ],
                ),
              ),
            ),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(top: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                child: Text(widget.offerData["description"],
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
