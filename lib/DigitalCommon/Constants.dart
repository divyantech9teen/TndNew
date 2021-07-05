import 'package:flutter/material.dart';

class APIURL {
  static const String API_URL =
      "http://digitalvcard.thenationaldawn.in/DigitalcardService.asmx/";
  static const String API_URL1 = "https://new-digital-card.herokuapp.com/";
  static const String API_URL_RazorPay_Order =
      "http://razorpayapi.itfuturz.com/Service.asmx/";
}

const Inr_Rupee = "₹";
const Color appcolor = Color.fromRGBO(48, 131, 201, 1);
const Color buttoncolor = Color.fromRGBO(85, 96, 128, 1);
const String whatsAppLink =
    "https://wa.me/#mobile?text=#msg"; //mobile no with country code
const String smsLink = "sms:#mobile?body=#msg"; //mobile no with country code
const String mailLink =
    "mailto:#mail?subject=#subject&body=#msg"; //mobile no with country code
const String shareMessage =
    "hello #recever, \nmy name is #sender \nyou can see my digital visiting card from the below link. \n#link \nRegards \n#sender";
// const String profileUrl =
//     "http://digitalvcard.thenationaldawn.in/Card3/Default.aspx?uid=#id";
//by rinki
const String profileUrl =
    "https://www.thenationaldawn.in/digicard/index.php?uid=#id";
const String playstoreUrl = "https://urlzs.com/JzR8A";
//const String inviteFriMsg = "http://digitalcard.co.in?uid=#id, smart & simple app to manage your digital visiting card & business profile.\nDownload the app from #appurl and use my refer code “#refercode” to get 15 days free trial.";
const String inviteFriMsg =
    "Hi there, \nYou came to my mind as I was using this interesting App *'Digital Card'*.\nhttp://digitalvcard.thenationaldawn.in/Card3/Default.aspx?uid=#id.\nI have been using this App to manage my business smartly & in a digital way.\nYou can also create your own business profile.\n\n*Download the App from the below link*. #appurl";
const String directShareMsg =
    "Hello Sir, \nMy name is #sender \nyou can see my digital visiting card from the below link \n#link \nRegards \n#sender \n\Download the App from the below link to make your own visiting card \n#applink";

class Session {
  static const String Session_Login = "Login_Data";
  static const String MemberId = "MemberId";
  static const String Name = "Name";
  static const String Mobile = "Mobile";
  static const String Company = "Company";
  static const String Email = "Email";
  static const String ReferCode = "ReferCode";
  //by rinki
  static const String website = "website";
  static const String faceBook = "faceBook";
  static const String instagram = "instagram";
  static const String linkedIn = "linkedIn";
  static const String twitter = "twitter";
  static const String youTube = "youTube";
  static const String panNo = "panNo";
  static const String googlePage = "googlePage";
  static const String about = "about";
  static const String role = "role";
  static const String gstNo = "gstNo";
  static const String mapLocation = "mapLocation";
  static const String shareMsg = "shareMsg";
  static const String company_website = "company_website";
  static const String company_mobile = "company_mobile";
  static const String company_address = "company_address";
  static const String company_email = "company_email";
  static const String imagecode = "imagecode";
  static const String coverimg = "coverimg";
  static const String name = "name";
  static const String mobile = "mobile";
  static const String email = "email";
  static const String whatsapp = "whatsapp";
  static const String isVerified = "isVerified";
  static const String company_name = "company_name";
  static const String LogoImage = "LogoImage";

  //====
  static const String IsAppIntroCompleted = "IsAppIntroCompleted";
  static const String CardPaymentAmount = "CardPaymentAmount";
  static const String IsActivePayment = "IsActivePayment";
}

class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}

class COLORS {
  // App Colors //
  static const Color DRAWER_BG_COLOR = Colors.lightGreen;
  static const Color APP_THEME_COLOR = Colors.green;
}

//Material Color
Map<int, Color> appColorMap = {
  50: Color.fromRGBO(48, 131, 201, .1),
  100: Color.fromRGBO(48, 131, 201, .2),
  200: Color.fromRGBO(48, 131, 201, .3),
  300: Color.fromRGBO(48, 131, 201, .4),
  400: Color.fromRGBO(48, 131, 201, .5),
  500: Color.fromRGBO(48, 131, 201, .6),
  600: Color.fromRGBO(48, 131, 201, .7),
  700: Color.fromRGBO(48, 131, 201, .8),
  800: Color.fromRGBO(48, 131, 201, .9),
  900: Color.fromRGBO(48, 131, 201, 1),
};

MaterialColor appMaterialColor = MaterialColor(0xFF3083C9, appColorMap);
