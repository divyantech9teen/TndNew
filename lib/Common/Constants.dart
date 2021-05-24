import 'package:flutter/material.dart';

//const String SOAP_API_URL = "http://pmc.studyfield.com/Service.asmx/";
const String API_URL = "http://15.207.46.236/";
//const String API_URL = "https://tnd-tmp.herokuapp.com/admin/";
//const String API_URL = "https://blogproject-33.herokuapp.com/";
//const String API_URL = "http://15.207.46.236/";

const String API_URL2 = "https://blogproject-33.herokuapp.com/";
//const String API_URL = "https://tnd-tmp.herokuapp.com/";
const String API_URL1 = "http://www.thenationaldawn.in/wp-json/";
const String Image_URL = "http://15.207.46.236/";

const Inr_Rupee = "₹";
const Color appcolor = Color.fromRGBO(0, 171, 199, 1);
const Color secondaryColor = Color.fromRGBO(85, 96, 128, 1);

//const String whatsAppLink = "https://wa.me/#mobile?text=#msg"; //mobile no with country code

Map<int, Color> appprimarycolors = {
  50: Color.fromRGBO(0, 152, 219, .1),
  100: Color.fromRGBO(0, 152, 219, .2),
  200: Color.fromRGBO(0, 152, 219, .3),
  300: Color.fromRGBO(0, 152, 219, .4),
  400: Color.fromRGBO(0, 152, 219, .5),
  500: Color.fromRGBO(0, 152, 219, .6),
  600: Color.fromRGBO(0, 152, 219, .7),
  700: Color.fromRGBO(0, 152, 219, .8),
  800: Color.fromRGBO(0, 152, 219, .9),
  900: Color.fromRGBO(0, 152, 219, 1)
};

MaterialColor appPrimaryMaterialColor =
    MaterialColor(0xFF0098db, appprimarycolors);

class Session {
  static const String CustomerId = "CustomerId";
  static const String ismember = "ismember";
  static const String CustomerName = "CustomerName";
  static const String referred_by = "referred_by";
  static const String addressId = "addressId";
  static const String type = "type";
  static const String CustomerCompanyName = "CustomerCompanyName";
  static const String CustomerEmailId = "CustomerEmailId";
  static const String CustomerPhoneNo = "CustomerPhoneNo";
  static const String CustomerCDT = "CustomerCDT";
  static const String CustomerImage = "CustomerImage";
  static const String DOB = "date_of_birth";
  static const String experience = "experience";
  static const String achievement = "achievement";
  static const String faceBook = "faceBook";
  static const String instagram = "instagram";
  static const String linkedIn = "linkedIn";
  static const String twitter = "twitter";
  static const String youTube = "youTube";
  static const String memberOf = "memberOf";
  static const String gender = "gender";
  static const String spouse_name = "spouse_name";
  static const String spouse_birth_date = "spouse_birth_date";
  static const String number_of_child = "number_of_child";
  static const String date_of_birth = "date_of_birth";
  static const String business_category = "business_category";
  static const String address = "address";
  static const String isVerified = "isVerified";
  static const String about_business = "about_business";
  static const String digital_Id = "digital_Id";
  static const String forFirstTime = "forFirstTime";
}
