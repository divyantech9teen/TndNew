import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';
import 'package:the_national_dawn/Components/SocialMediaComponent.dart';
import 'package:the_national_dawn/Screens/CalendarDetailScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCalendarScreen extends StatefulWidget {
  @override
  _HomeCalendarScreenState createState() => _HomeCalendarScreenState();
}

class _HomeCalendarScreenState extends State<HomeCalendarScreen>
    with TickerProviderStateMixin {
  bool isLoading = true;
  Map<DateTime, List<Event>> _visibleEvents;
  CalendarController _calendarController;

  List _allEventList = [];
  List _currentMonthEventList = [];

  DateTime _currentDate = new DateTime.now();
  DateTime _currentDate2 = new DateTime.now();

  DateTime _currentMonth = DateTime.now();
  DateTime _targetDateTime = new DateTime.now();

  @override
  void initState() {
    _visibleEvents = {};
    _calendarController = new CalendarController();
    _getEventData();
  }

  _showDialog(BuildContext context, var eventDetail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Eventdailog(
          eventData: eventDetail,
        );
      },
    );
  }

  _monthEventData() {
    setState(() {
      _currentMonthEventList = [];
    });
    for (var i = 0; i < _allEventList.length; i++) {
      List splitData = _allEventList[i]["startDate"][0].toString().split("/");
      DateTime startDate =
          DateTime.parse("${splitData[2]}-${splitData[1]}-${splitData[0]}");
      var splitData2 = _allEventList[i]["endDate"][0].toString().split('/');
      DateTime endDate =
          DateTime.parse("${splitData2[2]}-${splitData2[1]}-${splitData2[0]}");

      String month = _currentMonth.month.toString().length == 1
          ? "0" + _currentMonth.month.toString()
          : _currentMonth.month.toString();

      if ((splitData[1] == month || splitData2[1] == month) &&
          (splitData[2] == _currentMonth.year.toString() ||
              splitData2[2] == _currentMonth.year.toString())) {
        setState(() {
          _currentMonthEventList.add(_allEventList[i]);
        });
      }
    }
  }

  _getEventData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.PostForList(
          api_name: 'admin/getEvents',
        ).then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              _allEventList = ResponseList;
            });
            Map<DateTime, List<Event>> temp = {};
            for (var i = 0; i < ResponseList.length; i++) {
              List splitData =
                  ResponseList[i]["startDate"][0].toString().split("/");
              DateTime startDate = DateTime.parse(
                  "${splitData[2]}-${splitData[1]}-${splitData[0]}");
              var splitData2 =
                  ResponseList[i]["endDate"][0].toString().split('/');
              DateTime endDate = DateTime.parse(
                  "${splitData2[2]}-${splitData2[1]}-${splitData2[0]}");
              _monthEventData();
              for (DateTime j = startDate;
                  j.isBefore(endDate) || j == endDate;
                  j = j.add(Duration(days: 1))) {
                if (temp.containsKey(j)) {
                  temp.update(j, (value) {
                    List<Event> list = value;
                    list.add(
                      Event(
                        date: j,
                        title: _allEventList[i]["eventName"],
                        dot: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          color: Colors.green,
                          height: 6.0,
                          width: 6.0,
                        ),
                      ),
                    );
                    return list;
                  });
                } else {
                  temp.addAll({
                    j: [
                      Event(
                        date: j,
                        title: _allEventList[i]["eventName"],
                        dot: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          color: Colors.green,
                          height: 5.0,
                          width: 5.0,
                        ),
                      ),
                    ]
                  });
                }
              }
            }
            setState(() {
              _visibleEvents = temp;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No Data Found");
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

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEventList() {
    return ListView(
      shrinkWrap: true,
      children: _currentMonthEventList
          .map(
            (event) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendarDetailScreen(
                            eventData: event,
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 75.0),
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 8.0),
                          height: 107,
                          //width: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  event["eventOrganiseBy"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff4B4B4B),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  event["eventName"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Time : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: appPrimaryMaterialColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      event["startTime"] +
                                          "-" +
                                          event["endTime"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: appPrimaryMaterialColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Date : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: appPrimaryMaterialColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${event["startDate"][0] + "-" + event["endDate"][0]}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: appPrimaryMaterialColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(event["eventImage"]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
//
          )
          .toList(),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      print(first);
      print(last);
    });
  }

  /*bool isLoading = true;
  DateTime _selectedDay;
  Map<DateTime, List> _visibleEvents;
  List _selectedEvents = [];
  int _currentIndex = 0;
  CalendarController _calendarController;

  @override
  void initState() {
    _visibleEvents = {};
    _calendarController = new CalendarController();
    _getEventData();
  }

  _getEventData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        var body = {};
        Services.PostForList(
          api_name: 'admin/getEvents',
        ).then((ResponseList) async {
          setState(() {
            isLoading = false;
          });
          Map<DateTime, List> temp = {};
          if (ResponseList.length > 0) {
            for (var i = 0; i < ResponseList.length; i++) {
              List splitData =
                  ResponseList[i]["startDate"][0].toString().split("/");
              DateTime startDate = DateTime.parse(
                  "${splitData[2]}-${splitData[1]}-${splitData[0]}");
              var splitData2 =
                  ResponseList[i]["endDate"][0].toString().split('/');
              DateTime endDate = DateTime.parse(
                  "${splitData2[2]}-${splitData2[1]}-${splitData2[0]}");

              for (DateTime j = startDate;
                  j.isBefore(endDate) || j == endDate;
                  j = j.add(Duration(days: 1))) {
                temp.addAll({
                  j: [ResponseList[i]]
                });
              }
            }
            log(temp.toString());

            setState(() {
              _visibleEvents = temp;
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

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDaySelected(DateTime day, List events, _) {
    setState(() {
      _selectedDay = day;
      _selectedEvents = events;
    });
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      //holidays: _visibleHolidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,

      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        */ /*CalendarFormat.twoWeeks: '2 weeks',
        CalendarFormat.week: 'Week',*/ /*
      },
      calendarStyle: CalendarStyle(
        selectedColor: appPrimaryMaterialColor,
        todayColor: appPrimaryMaterialColor[200],
        markersColor: Colors.deepOrange,
        //markersMaxAmount: 7,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: appPrimaryMaterialColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      calendarController: _calendarController,
    );
  }

  Widget _buildEventList() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        shrinkWrap: true,
        children: _selectedEvents
            .map(
              (event) => Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 75.0),
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 8.0),
                          height: 107,
                          //width: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  event["eventOrganiseBy"],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff4B4B4B),
                                      fontWeight: FontWeight.w600),
                                ),
//                                Text(
//                                  "Owl factory Solutions",
//                                  style: TextStyle(
//                                      fontSize: 10, color: Color(0xff4B4B4B)),
//                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  event["eventName"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  event["startTime"] + "-" + event["endTime"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: appPrimaryMaterialColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 49,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(event["eventImage"]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
//                  Container(
//                decoration: BoxDecoration(
//                  border: Border.all(width: 0.8),
//                  borderRadius: BorderRadius.circular(12.0),
//                ),
//                margin:
//                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                child: ListTile(
//                  title: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(event["Name"]),
//                      Text(event["Venue"]),
//                    ],
//                  ),
//                  onTap: () {
//                    String selectedDate =
//                        _selectedDay.toString().substring(0, 10);
////                      Navigator.push(
////                        context,
////                        MaterialPageRoute(
////                          builder: (context) => EventDetailList(
////                            date: selectedDate,
////                            events: _selectedEvents,
////                          ),
////                        ),
////                      );
//                  },
//                ),
//              ),
            )
            .toList(),
      ),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      print(first);
      print(last);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "Calendar",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontSize: 18,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 30.0,
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: new Row(
                      children: <Widget>[
                        FlatButton(
                          child: Icon(Icons.arrow_back_ios_outlined),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(_targetDateTime.year,
                                  _targetDateTime.month - 1);
                              _currentMonth = _targetDateTime;
                            });
                          },
                        ),
                        Expanded(
                            child: Text(
                          DateFormat.yMMM().format(_currentMonth),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )),
                        FlatButton(
                          child: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(_targetDateTime.year,
                                  _targetDateTime.month + 1);
                              _currentMonth = _targetDateTime;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: CalendarCarousel<Event>(
                      todayBorderColor: appPrimaryMaterialColor,
                      // dayButtonColor: appPrimaryMaterialColor[300],
                      selectedDayBorderColor: appPrimaryMaterialColor,

                      onDayPressed: (DateTime date, List<Event> events) {
                        this.setState(() => _currentDate2 = date);
                        events.forEach((event) => print(event.title));
                      },
                      daysHaveCircularBorder: true,
                      showOnlyCurrentMonthDate: false,
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                      thisMonthDayBorderColor: Colors.grey,
                      weekFormat: false,
//      firstDayOfWeek: 4,
                      markedDatesMap: EventList<Event>(
                        events: _visibleEvents,
                      ),
                      height: 300.0,
                      selectedDateTime: _currentDate2,
                      targetDateTime: _targetDateTime,
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      markedDateCustomShapeBorder: CircleBorder(
                          side: BorderSide(color: appPrimaryMaterialColor)),
                      markedDateCustomTextStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                      showHeader: false,
                      todayTextStyle: TextStyle(
                        color: appPrimaryMaterialColor,
                      ),
                      todayButtonColor: Colors.white,
                      selectedDayTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      minSelectedDate:
                          _currentDate.subtract(Duration(days: 360)),
                      maxSelectedDate: _currentDate.add(Duration(days: 360)),
                      prevDaysTextStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      selectedDayButtonColor: appPrimaryMaterialColor,
                      inactiveDaysTextStyle: TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 16,
                      ),
                      onCalendarChanged: (DateTime date) {
                        this.setState(() {
                          _targetDateTime = date;
                          _currentMonth = _targetDateTime;
                          print(_currentMonth);
                        });
                        _monthEventData();
                      },
                      onDayLongPressed: (DateTime date) {
                        print('long pressed date $date');
                      },
                    ),
                  ),
                  _buildEventList(),
                ],
              ),
            ),

      /* ListView(
        children: <Widget>[
          _buildTableCalendar(),
          _buildEventList(),
        ],
      ),*/
    );
  }
}

class Eventdailog extends StatefulWidget {
  String instagram, facebook, linkedIn, twitter, whatsapp;
  var eventData;
  Eventdailog(
      {this.instagram,
      this.facebook,
      this.linkedIn,
      this.twitter,
      this.whatsapp,
      this.eventData});

  @override
  _EventdailogState createState() => _EventdailogState();
}

class _EventdailogState extends State<Eventdailog> {
  void launchwhatsapp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  launchSocialMediaUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.eventData);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        width: 320,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Center(
                  child: Text(
                    "${widget.eventData["eventName"]}",
                    style: TextStyle(
                        fontSize: 19,
                        color: appPrimaryMaterialColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Organized by : ",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${widget.eventData["eventOrganiseBy"]}",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Date : ",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${widget.eventData["startDate"][0] + "To" + widget.eventData["endDate"][0]}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Time : ",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${widget.eventData["startTime"]}" +
                          "-" +
                          "${widget.eventData["endTime"]}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                child: Image.network(
                  "${widget.eventData['eventImage']}",
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 20),
                child: Text(
                  "Description : ",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              ),*/

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
                child: Text(
                  "${widget.eventData["description"]}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 20, right: 20),
                child: SocialMediaComponent(
                  facebook: widget.eventData["faceBook"],
                  instagram: widget.eventData["instagram"],
                  linkedIn: widget.eventData["linkedIn"],
                  twitter: widget.eventData["twitter"],
                  whatsapp: widget.eventData["whatsApp"],
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, top: 5, bottom: 5),
                          child: Image.asset(
                            'assets/face.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, top: 5, bottom: 5),
                          child: Image.asset(
                            'assets/insta.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, top: 5, bottom: 5),
                          child: Image.asset(
                            'assets/link.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, top: 5, bottom: 5),
                          child: Image.asset(
                            'assets/whats.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, top: 5, bottom: 5),
                          child: Image.asset(
                            'assets/youtu.png',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5, top: 5, bottom: 5),
                          child: Image.asset(
                            'assets/twit.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}
