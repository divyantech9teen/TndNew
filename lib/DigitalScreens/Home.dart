import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/DigitalCommon/Services.dart' as serv;
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:the_national_dawn/DigitalComponent/CardShareComponent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  DashboardCountClass _dashboardCount =
      new DashboardCountClass(visitors: '0', calls: '0', share: '0');

  bool isLoading = false;
  bool isProfileLoading = true;
  bool IsActivePayment = false;
  bool IsExpired = false;

  String MemberId = "";
  String DigitalId = "";
  String Name = "";
  String Company = "";
  String Photo = "";
  String CoverPhoto = "";
  String ReferCode = "";
  String ExpDate = "";
  String MemberType = "";
  String ShareMsg = "";
  String txtName;
  String txtCompany;
  String ismember;
  bool isVerified = false;
  bool isMember = false;

  Map<String, dynamic> profileList = {};
  List digitalList = [];

  @override
  void initState() {
    super.initState();
    // GetProfileData();
    GetDashboardCount();
    GetLocalData();
    _getUpdatedProfile();
  }

//by rinki
  CreateDigital(
      String Mobile1,
      String Name1,
      String Email,
      String Company1,
      String Referal,
      String Image,
      String Whatsapp,
      String Fb,
      String Insta,
      String Linkin,
      String Twitter,
      String Youtube,
      String CompanyWebsite,
      String CompEmail,
      String CompAdd,
      String CompMoblie,
      String PAN,
      String About,
      String GooglePage,
      String Role,
      String GST,
      String MapLocation,
      String ShareMsg1,
      String AboutComp,
      String CoverImg1,
      String LogoImage) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "referalcode": Referal,
          "myreferalcode": "",
          "name": Name1,
          "mobile": Mobile1,
          "company_name": Company1,
          "email": Email,
          "whatsapp": Whatsapp,
          "faceBook": Fb,
          "instagram": Insta,
          "linkedIn": Linkin,
          "twitter": Twitter,
          "youTube": Youtube,
          "company_website": CompanyWebsite,
          "company_email": CompEmail,
          "company_address": CompAdd,
          "company_mobile": CompMoblie,
          "panNo": PAN,
          "about": About,
          "googlePage": GooglePage,
          "role": Role,
          "gstNo": GST,
          "mapLocation": MapLocation,
          "shareMsg": ShareMsg1,
          "about_company": AboutComp,
          "imagecode": Image,
          "covering": CoverImg1,
          "website": CompanyWebsite,
          "digiCardLogo": LogoImage
        });

        log(prefs.getString(Session.CustomerId));
        serv.Services.PostForList4(
                api_name: 'card/checkDigitalCardMember', body: body)
            .then((subCatResponseList) async {
          log("a022222");
          setState(() {
            isLoading = false;
          });
          if (subCatResponseList.length > 0) {
            log("a122222");
            setState(() {
              digitalList = subCatResponseList;
              //set "data" here to your variable
            });
            //   Fluttertoast.showToast(msg: "Login successfully");
            // print("========================${digitalList[0].Id}");
            SharedPreferences prefs = await SharedPreferences.getInstance();

            setState(() {
              MemberId = subCatResponseList[0]["_id"];
              Name = subCatResponseList[0]["name"];
              Company = subCatResponseList[0]["company_name"];
              Photo = subCatResponseList[0]["imagecode"] != null
                  ? subCatResponseList[0]["imagecode"]
                  : profileList["img"];
              CoverPhoto = subCatResponseList[0]["coverimg"] != null
                  ? subCatResponseList[0]["coverimg"]
                  : "";
              ReferCode = "${Referal}";
              ExpDate = "";
              MemberType = "";
              ShareMsg = "";
            });
            setState(() {});
            await prefs.setString(
                Session.digital_Id, subCatResponseList[0]["_id"]);
            DigitalId = prefs.getString(Session.digital_Id);
            await prefs.setString(
                cnst.Session.MemberId, subCatResponseList[0]["_id"]);
            await prefs.setString(cnst.Session.ReferCode, Referal);
            await prefs.setString(
                cnst.Session.website, subCatResponseList[0]["website"]);
            await prefs.setString(
                cnst.Session.faceBook, subCatResponseList[0]["faceBook"]);
            await prefs.setString(
                cnst.Session.instagram, subCatResponseList[0]["instagram"]);
            await prefs.setString(
                cnst.Session.linkedIn, subCatResponseList[0]["linkedIn"]);
            await prefs.setString(
                cnst.Session.twitter, subCatResponseList[0]["twitter"]);
            await prefs.setString(
                cnst.Session.youTube, subCatResponseList[0]["youTube"]);
            await prefs.setString(
                cnst.Session.panNo, subCatResponseList[0]["panNo"]);
            await prefs.setString(
                cnst.Session.googlePage, subCatResponseList[0]["googlePage"]);
            await prefs.setString(
                cnst.Session.about, subCatResponseList[0]["about"]);
            await prefs.setString(
                cnst.Session.role, subCatResponseList[0]["role"]);
            await prefs.setString(
                cnst.Session.gstNo, subCatResponseList[0]["gstNo"]);
            await prefs.setString(
                cnst.Session.mapLocation, subCatResponseList[0]["mapLocation"]);
            await prefs.setString(
                cnst.Session.shareMsg, subCatResponseList[0]["shareMsg"]);
            await prefs.setString(cnst.Session.company_website,
                subCatResponseList[0]["company_website"]);
            await prefs.setString(cnst.Session.company_mobile,
                subCatResponseList[0]["company_mobile"]);
            await prefs.setString(cnst.Session.company_address,
                subCatResponseList[0]["company_address"]);
            await prefs.setString(cnst.Session.company_email,
                subCatResponseList[0]["company_email"]);
            await prefs.setString(
                cnst.Session.imagecode, subCatResponseList[0]["imagecode"]);
            await prefs.setString(
                cnst.Session.coverimg, subCatResponseList[0]["coverimg"]);
            await prefs.setString(
                cnst.Session.name, subCatResponseList[0]["name"]);
            await prefs.setString(
                cnst.Session.mobile, subCatResponseList[0]["mobile"]);
            await prefs.setString(
                cnst.Session.email, subCatResponseList[0]["email"]);
            await prefs.setString(
                cnst.Session.whatsapp, subCatResponseList[0]["whatsapp"]);
            await prefs.setString(cnst.Session.company_name,
                subCatResponseList[0]["company_name"]);
            await prefs.setString(
                cnst.Session.LogoImage, subCatResponseList[0]["digiCardLogo"]);

            //   GetProfileData();
            //Fluttertoast.showToast(msg: "Login successfully");
          } else {
            log("a222");
            setState(() {
              digitalList = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
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

//old create digital
//   CreateDigital(String Mobile, String Name, String Email) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       //Future res = Services.MemberLogin(prefs.getString(cnst.Session.Mobile));
//       setState(() {
//         isLoading = true;
//       });
//       serv.Services.CreateDigitalCard(
//         Mobile,
//         Name,
//         Email,
//       ).then((data) async {
//         if (data != null && data.length > 0) {
//           setState(() {
//             isLoading = false;
//           });
//           print("length : ${data.length}");
//           if (data.length > 0) {
//             setState(() {
//               isLoading = false;
//               // isMultipleCard = true;
//               digitalList = data;
//             });
//             print("========================${digitalList[0].Id}");
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setString(Session.digital_Id, digitalList[0].Id);
//             DigitalId = prefs.getString(Session.digital_Id);
//             GetProfileData();
//           }
//         } else {
//           setState(() {
//             isLoading = false;
//           });
//           showMsg("Data Send");
//         }
//       }, onError: (e) {
//         setState(() {
//           isLoading = false;
//         });
//         print("Error : Data Not Saved");
//         showMsg("$e");
//       });
//     } catch (Ex) {
//       setState(() {
//         isLoading = false;
//       });
//       showMsg("Something Went Wrong");
//     }
//   }

  // CreateDigital(String Mobile, String Name, String Email) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   print("==============================");
  //
  //   serv.Services.CreateDigitalCard(
  //     Mobile,
  //     Name,
  //     Email,
  //   ).then((data) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     //log("outside");
  //     if (data != null && data.ERROR_STATUS == false && data.RECORDS == true) {
  //       //    log("inside true");
  //       // setState(() {
  //       //   digitalList = data.Data;
  //       // });
  //       // print("========================+${data.Data}");
  //       Fluttertoast.showToast(
  //         msg: "Data Send ",
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //       );
  //     } else {
  //       // log("inside false");
  //       Fluttertoast.showToast(
  //           msg: "Data Not Saved " + data.MESSAGE,
  //           backgroundColor: Colors.red,
  //           toastLength: Toast.LENGTH_LONG);
  //     }
  //   }, onError: (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(
  //         msg: "Data Not Saved      " + e.toString(),
  //         backgroundColor: Colors.red);
  //   });
  // }

  bool checkValidity() {
    if (ExpDate.trim() != null && ExpDate.trim() != "") {
      final f = new DateFormat('dd MMM yyyy');
      DateTime validTillDate = f.parse(ExpDate);
      print(validTillDate);
      DateTime currentDate = new DateTime.now();
      print(currentDate);
      if (validTillDate.isAfter(currentDate)) {
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isActivePayment = prefs.getBool(cnst.Session.IsActivePayment);

    if (isActivePayment != null)
      setState(() {
        IsActivePayment = isActivePayment;
        print(isActivePayment);
      });
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Digital Card"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  GetProfileData() {
    setState(() {
      isLoading = true;
    });
    serv.Services.GetMemberDetail().then((data) {
      setState(() {
        MemberId = data[0].Id;
        Name = data[0].Name;
        Company = data[0].Company;
        Photo = data[0].Image != null ? data[0].Image : profileList["img"];
        CoverPhoto = data[0].CoverImage != null ? data[0].CoverImage : "";
        ReferCode = data[0].MyReferralCode;
        ExpDate = data[0].ExpDate;
        MemberType = data[0].MemberType;
        ShareMsg = data[0].ShareMsg;
        isLoading = false;
      });
      print("MemberType : $MemberType");
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  GetDashboardCount() async {
    setState(() {
      isLoading = true;
    });
    serv.Services.GetDashboardCount().then((val) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (val != null && val.length > 0) {
        await prefs.setString(
            cnst.Session.CardPaymentAmount, val[0].cardAmount);
        print(val[0].cardAmount);
        setState(() {
          _dashboardCount = val[0];
        });
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  _getUpdatedProfile() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      setState(() {
        isProfileLoading = true;
      });

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var body = {
          "id": prefs.getString(Session.CustomerId),
        };
        print("=================================");
        print(prefs.getString(Session.CustomerId));
        print(prefs.getString(Session.ismember));
        setState(() {
          ismember = prefs.getString(Session.ismember);
        });

        Services.PostForList(api_name: 'admin/getsingleid', body: body).then(
            (ResponseList) async {
          setState(() {
            isProfileLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              profileList = ResponseList[0];
              //set "data" here to your variable
            });
            print("=================================11");
            print("=================================GIRISH THAKUR");
            prefs.setBool(Session.isVerified, ResponseList[0]["isVerified"]);
            print("${prefs.getBool(Session.isVerified)}");
            setState(() {
              isVerified = prefs.getBool(Session.isVerified);
              isMember = prefs.getBool(Session.isVerified);
            });
            print(
                "=================================GIRISH THAKUR${isVerified}");
            // CreateDigital(profileList["mobile"], profileList["name"],
            //     profileList["email"]);
            CreateDigital(
                profileList["mobile"],
                profileList["name"],
                profileList["email"],
                profileList["company_name"],
                profileList["referred_by"],
                profileList["img"],
                profileList["mobile"],
                profileList["faceBook"],
                profileList["instagram"],
                profileList["linkedIn"],
                profileList["twitter"],
                profileList["youTube"],
                "",
                profileList["email"],
                "",
                profileList["mobile"],
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                profileList["about_business"],
                profileList["img"],
                "");

            print("${ResponseList[0]}");
          } else {
            Fluttertoast.showToast(msg: "Product Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isProfileLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  @override
  Widget build(BuildContext context) {
    log("  '''''''''''''''' $isLoading");
    return isProfileLoading == false
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, right: 0, left: 10, bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/HomePage');
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
            body: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      child: FadeInImage.assetNetwork(
                          placeholder: "assets/profilebackground.png",
                          image: CoverPhoto,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover),
                      clipper: MyClipper(),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.24),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //   Photo == ""
                          profileList["img"] == ""
                              ? Container(
                                  decoration: new BoxDecoration(
                                      color: cnst.appMaterialColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(75))),
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      //  "${Name.toString().substring(0, 1)}",
                                      "${profileList["name"].toString().substring(0, 1)}",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: ClipOval(
                                    child: FadeInImage.assetNetwork(
                                        placeholder: "images/users.png",
                                        image: Photo,
                                        //image: profileList["img"],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                          //!isLoadingProfile
                          !isLoading
                              ? Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                            Name == ""
                                                ? "${profileList["name"]}"
                                                : Name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey[800],
                                                fontWeight: FontWeight.w600))),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, bottom: 0),
                                        child: Text(
                                            "${Company == "" ? profileList["company_name"] : Company}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w600))),
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, "/ProfileDetail"),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Edit Profile",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Icon(Icons.edit,
                                                  color: Colors.blue, size: 17),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                      strokeWidth: 3,
                                    ),
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(
                                        width: 0.5, color: Colors.grey[900])),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      gradient: new LinearGradient(colors: [
                                        cnst.appMaterialColor,
                                        cnst.buttoncolor
                                      ]),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey[500],
                                          blurRadius: 20.0,
                                          spreadRadius: 1.0,
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      !isLoading
                                          ? Text(_dashboardCount.visitors,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600))
                                          : SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                                strokeWidth: 3,
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text("Visitors",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                  ),
                                  height: 85,
                                  width: 85,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/ShareHistory'),
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side: BorderSide(
                                          width: 0.5, color: Colors.grey[900])),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: new LinearGradient(
                                            begin: FractionalOffset(0, 1.0),
                                            end: FractionalOffset(0, 0),
                                            colors: [
                                              cnst.appMaterialColor,
                                              cnst.buttoncolor
                                            ]),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[500],
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          )
                                        ]),
                                    child: Column(
                                      children: <Widget>[
                                        !isLoading
                                            ? Text(_dashboardCount.share,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600))
                                            : SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.blue),
                                                  strokeWidth: 3,
                                                ),
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text("Share",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                    height: 85,
                                    width: 85,
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(
                                        width: 0.5, color: Colors.grey[900])),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      gradient: new LinearGradient(colors: [
                                        cnst.buttoncolor,
                                        cnst.appMaterialColor
                                      ]),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey[500],
                                          blurRadius: 20.0,
                                          spreadRadius: 1.0,
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      !isLoading
                                          ? Text(_dashboardCount.calls,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600))
                                          : SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                                strokeWidth: 3,
                                              ),
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text("Calls",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                  ),
                                  height: 85,
                                  width: 85,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          ismember == "true"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          elevation: 5,
                                          textColor: Colors.white,
                                          color: cnst.buttoncolor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.share,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text("Share",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                              )
                                            ],
                                          ),
                                          onPressed: () {
                                            String profileUrl =
                                                "Hi there, \n You came to my mind as I was using this interesting App 'Digital Card'." +
                                                    cnst.profileUrl.replaceAll(
                                                        "#id", DigitalId) +
                                                    "\n I have been using this App to manage my business smartly & in a digital way. \n You can also create your own business profile \n\n Download the App from the below link." +
                                                    "https://play.google.com/store/apps/details?id=com.example1.the_national_dawn";
                                            Share.share(profileUrl);

                                            // bool val = checkValidity();
                                            // Navigator.of(context).push(
                                            //   PageRouteBuilder(
                                            //     opaque: false,
                                            //     pageBuilder:
                                            //         (BuildContext context, _, __) =>
                                            //             CardShareComponent(
                                            //       memberId: DigitalId,
                                            //       memberName: Name,
                                            //       isRegular: val,
                                            //       memberType: MemberType,
                                            //       shareMsg: ShareMsg,
                                            //       IsActivePayment: IsActivePayment,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0))),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          elevation: 5,
                                          textColor: Colors.white,
                                          color: cnst.buttoncolor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset("assets/logo.png",
                                                  height: 24, width: 24),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text("Refer",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                              )
                                            ],
                                          ),
                                          onPressed: () {
                                            // String withrefercode = cnst.inviteFriMsg
                                            //     .replaceAll("#refercode", ReferCode);
                                            String withappurl =
                                                cnst.inviteFriMsg.replaceAll(
                                                    "#appurl",
                                                    cnst.playstoreUrl);
                                            String withmemberid = withappurl
                                                .replaceAll("#id", DigitalId);
                                            Share.share(withmemberid);
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0))),
                                    )
                                  ],
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: (IsActivePayment == true) &&
                                    (MemberType.toLowerCase() == "trial" ||
                                        checkValidity() == false)
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.center,
                            children: <Widget>[
                              ismember == "true"
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          elevation: 5,
                                          textColor: Colors.white,
                                          color: cnst.buttoncolor,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text("View Card",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                              )
                                            ],
                                          ),
                                          onPressed: () async {
                                            String profileUrl = cnst.profileUrl
                                                .replaceAll("#id", DigitalId);
                                            if (await canLaunch(profileUrl)) {
                                              await launch(profileUrl);
                                            } else {
                                              throw 'Could not launch $profileUrl';
                                            }
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0))),
                                    )
                                  : Container(),
                              (IsActivePayment == true) &&
                                      (MemberType.toLowerCase() == "trial" ||
                                          checkValidity() == false)
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        elevation: 5,
                                        textColor: Colors.white,
                                        color: cnst.buttoncolor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                "${cnst.Inr_Rupee}  Pay Now",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/Payment');
                                        },
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: RaisedButton(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                elevation: 5,
                                textColor: Colors.white,
                                color: cnst.buttoncolor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.dashboard,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text("Back to DashBoard",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  Navigator.pushReplacementNamed(
                                      context, '/HomePage');
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 3,
            ),
          );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
/*class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();


    path.lineTo(0, 0);
    path.quadraticBezierTo(
        size.width / 2, 80, size.width, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height-80);
    //path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height, 0, size.height-80);


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*/
