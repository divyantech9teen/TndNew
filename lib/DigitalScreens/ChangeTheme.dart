import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

import 'package:url_launcher/url_launcher.dart';

class ChangeTheme extends StatefulWidget {
  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  bool isLoading = true;
  List<ThemeChange> ThemeClass = new List();

  bool isLoadingProfile = false;
  String MemberId = "";

  @override
  void initState() {
    _getThemeImage();
    GetProfileData();
  }

  _getThemeImage() async {
    Future res = Services.ChangeThemeImage();
    res.then((data) async {
      if (data != null && data.length > 0) {
        setState(() {
          isLoading = false;
          ThemeClass = data;
        });
      } else {
        setState(() {
          isLoading = true;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: "Something went Wrong",
          backgroundColor: Colors.red,
          gravity: ToastGravity.TOP);
    });
  }

  GetProfileData() {
    setState(() {
      isLoadingProfile = true;
    });
    Services.GetMemberDetail().then((data) {
      setState(() {
        MemberId = data[0].Id;
      });
    }, onError: (e) {
      setState(() {
        isLoadingProfile = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: new ListView.builder(
              itemCount: ThemeClass.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return new Container(
                  width: 300,
                  height: 500,
                  padding: new EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Image.network(
                            "${ThemeClass[index].Image}",
                            height: 420,
                            width: 400,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const ListTile(
                                //leading: Icon(Icons.album, size: 60),
                                // title: Text(
                                //     'Sonu Nigam',
                                //     style: TextStyle(fontSize: 30.0)
                                // ),
                                // subtitle: Text(
                                //     'Best of Sonu Nigam Music.',
                                //     style: TextStyle(fontSize: 18.0)
                                // ),
                                ),
                            ButtonBar(
                              children: <Widget>[
                                RaisedButton(
                                  child: const Text(
                                    'Preview',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.lightBlueAccent,
                                  onPressed: () async {
                                    String profileUrl = cnst.profileUrl
                                        .replaceAll("#id", MemberId);
                                    if (await canLaunch(profileUrl)) {
                                      await launch(profileUrl);
                                    } else {
                                      throw 'Could not launch $profileUrl';
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 45.0),
                                  child: RaisedButton(
                                    child: const Text(
                                      'Apply',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Future<String> mess =
                                          Services.UpdateTheme(
                                              MemberId, ThemeClass[index].Id);
                                      String profileUrl = cnst.profileUrl
                                          .replaceAll(
                                              MemberId, ThemeClass[index].Id);
                                      if (await canLaunch(profileUrl)) {
                                        await launch(profileUrl);
                                      } else {
                                        throw 'Could not launch $profileUrl';
                                      }
                                    },
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        centerTitle: false, title: Text("Theme"), actions: <Widget>[]);
  }
}
