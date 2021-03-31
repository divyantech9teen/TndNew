import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:the_national_dawn/Components/LoadingComponent.dart';

class UpdateProfileScreen extends StatefulWidget {
  var updatedProfileData;

  UpdateProfileScreen({this.updatedProfileData});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtSpouseName = TextEditingController();
  TextEditingController txtachievement = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtChildrenCount = TextEditingController();
  TextEditingController txtExperience = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAboutBusiness = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  TextEditingController txtWNumber = TextEditingController();
  TextEditingController txtGstNumber = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController instagram = TextEditingController();
  TextEditingController linkedIn = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController youTube = TextEditingController();

  String img, userName = "";
  final _formkey = new GlobalKey<FormState>();
  bool isLoading = false;
  String Gender, dob;
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  String _format = 'yyyy-MMMM-dd';
  DateTime _birthDate;
  DateTime _spouseBirthDate = DateTime.now();
  List<CategoryData> memberTypeList = [];
  CategoryData selectedOfferCat;
  bool isOfferLoading = false;
  String MemberTypeId;
  bool isCategoty = true;
  List<OfferClass> offerCatList = [];
  OfferClass selectedOfferCat2;

  bool isMemberLoading = true;
  List memberList = [];
  List selectedList = [];

  @override
  void initState() {
    _profile();
    getCategory();
    getMemberType();
    print("=========================${widget.updatedProfileData} ");
    _getMember();
  }

  getMemberType() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.GetMemberType().then((responseList) async {
          setState(() {
            isOfferLoading = true;
          });
          if (responseList.length > 0) {
            setState(() {
              isOfferLoading = false;
              memberTypeList = responseList;
            });
          } else {
            setState(() {
              isOfferLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isOfferLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  void _showBirthDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _birthDate,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _birthDate = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _birthDate = dateTime;
        });
        print(_birthDate);
      },
    );
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log("==============>abc${widget.updatedProfileData["member_id"]}");
    setState(() {
      txtName.text = "${widget.updatedProfileData["name"]}";
      Gender = "${widget.updatedProfileData["gender"]}";
      txtAddress.text = "${widget.updatedProfileData["address"]}";
      txtSpouseName.text = "${widget.updatedProfileData["spouse_name"]}";
      txtachievement.text = "${widget.updatedProfileData["achievement"]}";

      //img = prefs.getString(Session.CustomerImage);

      dob = "${widget.updatedProfileData["date_of_birth"]}";
      // dob = prefs.getString(Session.date_of_birth);
      if (dob != "null") {
        _birthDate = DateTime.parse(dob);
      }

      print("========================bdob");
      //print(_birthDate);
      if (widget.updatedProfileData["number_of_child"] != null) {
        txtChildrenCount.text =
            "${widget.updatedProfileData["number_of_child"]}";
      }

      // selectedList = prefs.getStringList(Session.memberOf);
      txtCName.text = "${widget.updatedProfileData["company_name"]}";
      txtEmail.text = "${widget.updatedProfileData["email"]}";
      txtMobileNumber.text = "${widget.updatedProfileData["mobile"]}";
      txtWNumber.text = "${widget.updatedProfileData["whatsApp"]}";
      txtAboutBusiness.text = "${widget.updatedProfileData["about_business"]}";
      txtExperience.text = "${widget.updatedProfileData["experience"]}";
      // = prefs.getString(Session.gender);

      facebook.text = "${widget.updatedProfileData["faceBook"]}";
      instagram.text = "${widget.updatedProfileData["instagram"]}";
      youTube.text = "${widget.updatedProfileData["youTube"]}";
      twitter.text = "${widget.updatedProfileData["twitter"]}";
      linkedIn.text = "${widget.updatedProfileData["linkedIn"]}";
      log("====================== img");
      //  print(Image_URL + img.toString());
//      print(img);
    });
    print("=================dob");
    print(dob);
    if (widget.updatedProfileData["member_id"] != null ||
        widget.updatedProfileData["member_id"] != "") {
      selectedList = widget.updatedProfileData["member_id"];
    }
  }

  File _Image;

  Future getFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  Future getFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15, bottom: 10),
                      child: Text(
                        "Add Photo",
                        style: TextStyle(
                          fontSize: 22,
                          color: appPrimaryMaterialColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/camera.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Take Photo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/gallery.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Choose from Gallery",
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0, bottom: 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: appPrimaryMaterialColor,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
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
            "Update Profile",
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
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 30.0, bottom: 25.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _settingModalBottomSheet();
                  },
                  child:
//
                      _Image != null ||
                              "${widget.updatedProfileData["img"]}" != ""
                          ? _Image != null
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    //  color: appPrimaryMaterialColor,
                                    //shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          color: appPrimaryMaterialColor
                                              .withOpacity(0.2),
                                          spreadRadius: 2,
                                          offset: Offset(3, 5)),
                                    ],
                                    image: DecorationImage(
                                        image: FileImage(
                                          _Image,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    //color: appPrimaryMaterialColor,
                                    //shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          color: appPrimaryMaterialColor
                                              .withOpacity(0.2),
                                          spreadRadius: 2,
                                          offset: Offset(3, 5)),
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "${widget.updatedProfileData["img"]}",
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                )
                          : Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.0),

                                //shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: appPrimaryMaterialColor
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      offset: Offset(3, 5)),
                                ],
                              ),
                              child: Center(
                                widthFactor: 40.0,
                                heightFactor: 40.0,
                                child: Image.asset("assets/051-user.png",
                                    color: Colors.white,
                                    width: 80.0,
                                    height: 80.0),
                              ),
                            ),
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          controller: txtName,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          validator: (name) {
                            if (name.length == 0) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(
                            //     vertical: 0.0, horizontal: 0.0),

                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 15, right: 5, top: 15, bottom: 15),

                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Gender",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                            value: 'Male',
                            groupValue: Gender,
                            onChanged: (value) {
                              setState(() {
                                Gender = value;
                                print(Gender);
                              });
                            }),
                        Text("Male", style: TextStyle(fontSize: 13)),
                        Radio(
                            value: 'Female',
                            groupValue: Gender,
                            onChanged: (value) {
                              setState(() {
                                Gender = value;
                                print(Gender);
                              });
                            }),
                        Text("Female", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Date of Birth",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showBirthDate();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black54),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: _birthDate == null
                                ? Center(
                                    child: Text(
                                    'Select Date of Birth',
                                    style: TextStyle(fontSize: 17),
                                  ))
                                : Center(
                                    child: Text(
                                    '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}',
                                    style: TextStyle(fontSize: 17),
                                  ))),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                      child: Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          controller: txtAddress,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          validator: (address) {
                            if (address.length == 0) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            //  errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 8, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                      child: Text(
                        'Spouse Name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          controller: txtSpouseName,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (sname) {
                          //   if (sname.length == 0) {
                          //     return 'Please enter spouse name';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 8, right: 5, top: 15, bottom: 15),
                            isDense: true,
                            errorStyle: TextStyle(height: 0),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),

/*                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Position',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          //border: Border.all(color: Colors.grey[500], width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: appPrimaryMaterialColor.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(3.0, 5.0))
                          ]),
                      child: TextFormField(
                        //controller: txtName,
                        controller: txtPosition,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: appPrimaryMaterialColor,
//                        validator: (position) {
//                          if (position.length == 0) {
//                            return 'Please enter your position';
//                          }
//                          return null;
//                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),*/
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        "Achievement",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          //controller: txtName,
                          controller: txtachievement,
                          keyboardType: TextInputType.text,
                          // validator: (ach) {
                          //   if (ach.length == 0) {
                          //     return 'Please enter your achievement';
                          //   }
                          //   return null;
                          // },
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'No Of Children',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          //controller: txtName,
                          controller: txtChildrenCount,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (child) {
                          //   if (child.length == 0) {
                          //     return 'Please enter your No. of child';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Company Name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          //controller: txtName,
                          controller: txtCName,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (cname) {
                          //   if (cname.length == 0) {
                          //     return 'Please enter company name';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Mobile Number',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 47,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          //controller: txtName,
                          controller: txtMobileNumber,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          maxLength: 10,
                          validator: (phone) {
                            Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                            RegExp regExp = new RegExp(pattern);
                            if (phone.length == 0) {
                              return 'Please enter mobile number';
                            } else if (!regExp.hasMatch(phone)) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Whatsapp Number',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          //controller: txtName,
                          controller: txtWNumber,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          maxLength: 10,
                          // validator: (wphone) {
                          //   Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                          //   RegExp regExp = new RegExp(pattern);
                          //   if (wphone.length == 0) {
                          //     return 'Please enter mobile number';
                          //   } else if (!regExp.hasMatch(wphone)) {
                          //     return 'Please enter valid mobile number';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            counterText: "",
                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 47,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                //border: Border.all(color: Colors.grey[500], width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: appPrimaryMaterialColor
                                          .withOpacity(0.2),
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                      offset: Offset(3.0, 5.0))
                                ]),
                          ),
                          TextFormField(
//                      controller: txtEmail,
                            controller: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 15),
                            cursorColor: Colors.black,
                            validator: (email) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              print(email);
                              if (email.isEmpty) {
                                return 'Please enter email';
                              } else {
                                if (!regex.hasMatch(email))
                                  return 'Enter valid Email Address';
                                else
                                  return null;
                              }
                            },
                            decoration: InputDecoration(
                              // errorStyle: TextStyle(height: 0),
                              // errorStyle: TextStyle(height: 0),
                              contentPadding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 15, bottom: 15),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 5, bottom: 5),
                      child: Text(
                        'Member Type',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    //''''''''''''''''''''''''''''

                    //=======================
                    ListView.builder(
                        itemCount: memberList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 40,
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,

                              title: Text(
                                memberList[index]["memberShipName"],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),

                              value: selectedList
                                  .contains(memberList[index]["_id"]),
                              //value: true,
                              activeColor: appPrimaryMaterialColor,
                              onChanged: (bool val1) {
                                setState(() {
                                  String value = memberList[index]["_id"];
                                  if (val1) {
                                    selectedList.add(value);
                                  } else {
                                    selectedList.remove(value);
                                  }
                                });
                                print(selectedList);
                              },
                            ),
                          );
                        }),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 5, bottom: 5),
                      child: Text(
                        'Business Category',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 15),
                      child: Container(
                          height: 38,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: appPrimaryMaterialColor)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: isCategoty
                                  ? LoadingBlueComponent()
                                  : DropdownButton<OfferClass>(
//                                hint: dropdownValue == null
//                                    ? Text(
//                                        "Select category",
//                                        style: TextStyle(
//                                          color: Colors.black,
//                                        ),
//                                      )
//                                    : Text(dropdownValue),
                                      dropdownColor: Colors.white,
                                      hint: Text("Select Business Category"),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                      isExpanded: true,
                                      value: selectedOfferCat2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOfferCat2 = value;
                                        });
                                      },
                                      items: offerCatList.map(
                                        (OfferClass category) {
                                          return DropdownMenuItem<OfferClass>(
                                            child: Text(category.offerName),
                                            value: category,
                                          );
                                        },
                                      ).toList(),
                                    ),
                            ),

//                          DropdownButtonHideUnderline(
//                        child: DropdownButton(
//                          hint: dropdownValue == null
//                              ? Text(
//                                  "Select category",
//                                  style: TextStyle(
//                                    color: Colors.black,
//                                  ),
//                                )
//                              : Text(dropdownValue),
//                          dropdownColor: Colors.white,
//                          icon: Icon(
//                            Icons.arrow_drop_down,
//                            size: 40,
//                            color: Colors.black,
//                          ),
//                          isExpanded: true,
//                          value: dropdownValue,
//                          items: [
//                            "Sports",
//                            "Entertainment",
//                            "Politics",
//                            "Religion"
//                          ].map((value) {
//                            return DropdownMenuItem<String>(
//                                value: value, child: Text(value));
//                          }).toList(),
//                          onChanged: (value) {
//                            setState(() {
//                              dropdownValue = value;
//                            });
//                          },
//                        ),
//                      ),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'About Business',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                        ),
                        TextFormField(
                          //controller: txtName,
                          controller: txtAboutBusiness,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (business) {
                          //   if (business.length == 0) {
                          //     return 'Please enter about business';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            counterText: "",
                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.only(
                                left: 5, right: 5, top: 15, bottom: 15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        'Experience',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 47,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(color: Colors.grey[500], width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: appPrimaryMaterialColor
                                        .withOpacity(0.2),
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(3.0, 5.0))
                              ]),
                          child: TextFormField(
                            //controller: txtName,
                            controller: txtExperience,
                            // validator: (exp) {
                            //   if (exp.length == 0) {
                            //     return 'Please enter your experience';
                            //   }
                            //   return null;
                            // },
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 15),
                            cursorColor: appPrimaryMaterialColor,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              counterText: "",
                              contentPadding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 15, bottom: 15),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                      child: Text(
                        "Social Media Links",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: facebook,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (fb) {
                          //   if (fb.length == 0) {
                          //     return 'Please enter your facebook Link';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: "Facebook Link",
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: instagram,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          // validator: (insta) {
                          //   if (insta.length == 0) {
                          //     return 'Please enter your instagram link';
                          //   }
                          //   return null;
                          // },
                          cursorColor: appPrimaryMaterialColor,
                          decoration: InputDecoration(
                            hintText: "Instagram Link",
                            errorStyle: TextStyle(height: 0),
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: linkedIn,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (linkin) {
                          //   if (linkin.length == 0) {
                          //     return 'Please enter your linkedin link';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: "LinkedIn Link",
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: twitter,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (twitter) {
                          //   if (twitter.length == 0) {
                          //     return 'Please enter your twitter link';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: "Twitter Link",
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      appPrimaryMaterialColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 5.0))
                            ]),
                        child: TextFormField(
                          //controller: txtName,
                          controller: youTube,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: appPrimaryMaterialColor,
                          // validator: (youtube) {
                          //   if (youtube.length == 0) {
                          //     return 'Please enter your youtube link';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: "Youtube Link",
                            contentPadding: const EdgeInsets.all(15),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          _updateProfile();
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: appPrimaryMaterialColor[500],
                            //border: Border.all(color: Colors.grey[500], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
//                          boxShadow: [
//                            BoxShadow(
//                                color: appPrimaryMaterialColor.withOpacity(0.2),
//                                blurRadius: 2.0,
//                                spreadRadius: 2.0,
//                                offset: Offset(3.0, 5.0))
//                          ]
                          ),
                          child: isLoading == true
                              ? Center(child: LoadingComponent())
                              : Center(
                                  child: Text('Update Profile',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500))),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCategory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getState().then((responseList) async {
          setState(() {
            isCategoty = true;
          });
          if (responseList.length > 0) {
            setState(() {
              isCategoty = false;
              offerCatList = responseList;
            });
            log("${responseList}");
            log("========================>xyz${widget.updatedProfileData["business_id"]}");
            log("========================>offer id${responseList[0].offerId}");
            for (int i = 0; i < responseList.length; i++) {
              if (responseList[i].offerId ==
                  widget.updatedProfileData["business_id"]) {
                selectedOfferCat2 = responseList[i];
                log("==========business class${responseList[i]}");
              }
            }
          } else {
            setState(() {
              isCategoty = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
          }
        }, onError: (e) {
          setState(() {
            isCategoty = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _getMember() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //FormData body = FormData.fromMap({"categoryId": widget.catId});
        Services.PostForList(api_name: 'admin/getAllMemberCategory').then(
            (ResponseList) async {
          setState(() {
            isMemberLoading = false;
          });
          if (ResponseList.length > 0) {
            //print("anirudh");
            setState(() {
              memberList = ResponseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isMemberLoading = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isMemberLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _updateProfile() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          String filename = "";
          String filePath = "";
          File compressedFile;
          if (_Image != null) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(_Image.path);

            compressedFile = await FlutterNativeImage.compressImage(
              _Image.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round(),
            );

            filename = _Image.path.split('/').last;
            filePath = compressedFile.path;
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();

          FormData body = FormData.fromMap({
            "id": prefs.getString(Session.CustomerId),
            "name": txtName.text,
            "mobile": txtMobileNumber.text,
            "email": txtEmail.text,
            "company_name": txtCName.text,
            "referred_by": prefs.getString(Session.referred_by),
            "date_of_birth": _birthDate.toString().split(" ")[0],
            "gender": Gender,
            "address": txtAddress.text,
            "spouse_name": txtSpouseName.text,
            "spouse_birth_date": _spouseBirthDate.toString().split(" ")[0],
            "achievement": txtachievement.text,
            "number_of_child": txtChildrenCount.text,
            "memberOf": selectedList,
            "experience": txtExperience.text,
            "about_business": txtAboutBusiness.text,
            "img": (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                    filename: filename.toString())
                : null,
            "faceBook": facebook.text,
            "whatsApp": txtWNumber.text,
            "instagram": instagram.text,
            "linkedIn": linkedIn.text,
            "twitter": twitter.text,
            "youTube": youTube.text,
            "business_category": selectedOfferCat2.offerId
          });
          print(body.fields);
          //"key":"value"
          Services.PostForList(
                  api_name: 'api/registration/updatePersonal', body: body)
              .then((responseList) async {
            setState(() {
              isLoading = false;
            });
            if (responseList.length > 0) {
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // setState(() {
              //   prefs.setString(Session.CustomerName, txtName.text);
              //   prefs.setString(Session.CustomerCompanyName, txtCName.text);
              //   prefs.setString(Session.CustomerEmailId, txtEmail.text);
              //   prefs.setString(Session.CustomerPhoneNo, txtMobileNumber.text);
              //   prefs.setString(Session.spouse_name, txtSpouseName.text);
              //   prefs.setString(Session.number_of_child, txtChildrenCount.text);
              //   prefs.setString(Session.about_business, txtAboutBusiness.text);
              //   prefs.setString(Session.experience, txtExperience.text);
              //   prefs.setString(Session.achievement, txtachievement.text);
              //   prefs.setString(Session.linkedIn, linkedIn.text);
              //   prefs.setString(Session.faceBook, facebook.text);
              //   prefs.setString(Session.youTube, youTube.text);
              //   prefs.setString(Session.instagram, instagram.text);
              //   prefs.setString(Session.twitter, twitter.text);
              //   prefs.setString(Session.address, txtAddress.text);
              //   prefs.setString(Session.gender, Gender);
              //   prefs.setString(Session.gender, Gender);
              //   //prefs.setStringList(Session.memberOf, selectedList);
              //   prefs.setString(
              //       Session.date_of_birth, responseList[0]["date_of_birth"]);
              //   prefs.setString(Session.CustomerImage, responseList[0]["img"]);
              // });
              Navigator.pushNamedAndRemoveUntil(
                  context, '/HomePage', (route) => false);
              Fluttertoast.showToast(
                  msg: "Profile Updated Successfully",
                  gravity: ToastGravity.BOTTOM);
            }

            setState(() {
              isLoading = false;
            });
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "Something Went Wrong");
            //showMsg("something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please Fill the Field");
    }
  }
}
