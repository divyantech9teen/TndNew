import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart' as cnst;
import 'package:url_launcher/url_launcher.dart';

class NotificationComponent extends StatefulWidget {
  var notificationData;

  NotificationComponent({this.notificationData});

  @override
  _NotificationComponentState createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  String dateData;
  List<String> date;
  String month;

  @override
  void initState() {
    //dateData = " ${widget.notificationData["date"]}";
    funDate();
  }

  funDate() {
    dateData = " ${widget.notificationData["date"]}";
    date = dateData.split(' ');
    print("-------------------->${date}");
    funMonth("${date[2]}");
  }

  funMonth(String mon) {
    if (mon == "01") {
      month = "Jan";
    } else if (mon == "02") {
      month = "Feb";
    } else if (mon == "03") {
      month = "March";
    } else if (mon == "04") {
      month = "April";
    } else if (mon == "05") {
      month = "May";
    } else if (mon == "06") {
      month = "June";
    } else if (mon == "07") {
      month = "July";
    } else if (mon == "08") {
      month = "Aug";
    } else if (mon == "09") {
      month = "Sept";
    } else if (mon == "10") {
      month = "Oct";
    } else if (mon == "11") {
      month = "Nov";
    } else if (mon == "12") {
      month = "Dec";
    } else {
      month = "";
    }
  }

  _launchURL() async {
    var url = "${widget.notificationData["meetingLink"]}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: cnst.appPrimaryMaterialColor),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //height: 80,
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          //color: Colors.blue,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  topLeft: Radius.circular(7)),
                              color: cnst.appPrimaryMaterialColor),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                " ${date[1]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 7, bottom: 7, left: 5, right: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: cnst.appPrimaryMaterialColor,
                                  width: 0.5),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6),
                                  bottomRight: Radius.circular(6)),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                " ${month}",
                                //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: cnst.appPrimaryMaterialColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                " ${date[3]}",
                                //  '${new DateFormat.MMM().format(DateTime.parse(DateFormat("yyyy-MM-dd").parse(widget.notification["Date"].toString().substring(0,10)).toString()))},${widget.notification["Date"].substring(0, 4)}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: cnst.appPrimaryMaterialColor,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          " ${widget.notificationData["notification"]["notificationTitle"]}",
                          //'${widget.notification["Title"]}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          // '${widget.notification["Description"]}',
                          "${widget.notificationData["notification"]["notificationBody"]}",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                        widget.notificationData["meetingType"] == "online"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(""),
                                  GestureDetector(
                                    onTap: () {
                                      _launchURL();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: cnst.appPrimaryMaterialColor,
                                            width: 0.5),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(7),
                                            bottomLeft: Radius.circular(7),
                                            bottomRight: Radius.circular(7),
                                            topLeft: Radius.circular(7)),
                                        // color: cnst.appPrimaryMaterialColor
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Connect",
                                          style: TextStyle(
                                              color:
                                                  cnst.appPrimaryMaterialColor,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
