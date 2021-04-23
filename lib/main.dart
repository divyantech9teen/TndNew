import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:the_national_dawn/DigitalScreens/AddCard.dart';
import 'package:the_national_dawn/DigitalScreens/AddOffer.dart';
import 'package:the_national_dawn/DigitalScreens/AddService.dart';
import 'package:the_national_dawn/DigitalScreens/ChangeTheme.dart';
import 'package:the_national_dawn/DigitalScreens/DashBoard.dart';
import 'package:the_national_dawn/DigitalScreens/EditOffer.dart';
import 'package:the_national_dawn/DigitalScreens/EditService.dart';
import 'package:the_national_dawn/DigitalScreens/Home.dart';
import 'package:the_national_dawn/DigitalScreens/More.dart';
import 'package:the_national_dawn/DigitalScreens/OfferDetail.dart';
import 'package:the_national_dawn/DigitalScreens/Offers.dart';
import 'package:the_national_dawn/DigitalScreens/ProfileDetail.dart';
import 'package:the_national_dawn/DigitalScreens/Services.dart';
import 'package:the_national_dawn/DigitalScreens/ShareHistory.dart';
import 'package:the_national_dawn/Screens/BookMarkDetailScreen.dart';
import 'package:the_national_dawn/Screens/BookMarkScreen.dart';
import 'package:the_national_dawn/Screens/BusinessCardScreen.dart';
import 'package:the_national_dawn/Screens/BussinessStoryScreen.dart';
import 'package:the_national_dawn/Screens/CalendarDetailScreen.dart';
import 'package:the_national_dawn/Screens/CalenderScreen.dart';
import 'package:the_national_dawn/Screens/CategoryScreen.dart';
import 'package:the_national_dawn/Screens/DailyNewScreen.dart';
import 'package:the_national_dawn/Screens/DirectoryScreen.dart';
import 'package:the_national_dawn/Screens/EventTicketScreen.dart';
import 'package:the_national_dawn/Screens/HomeCalendarScreen.dart';
import 'package:the_national_dawn/Screens/HomeCategoryScreen.dart';
import 'package:the_national_dawn/Screens/HomeNetworkScreen.dart';
import 'package:the_national_dawn/Screens/HomePage.dart';
import 'package:the_national_dawn/Screens/HomeScreen.dart';
import 'package:the_national_dawn/Screens/HomeStoriesScreen.dart';
import 'package:the_national_dawn/Screens/LoginScreen.dart';
import 'package:the_national_dawn/Screens/MemberDetailScreen.dart';
import 'package:the_national_dawn/Screens/MyEcardScreen.dart';
import 'package:the_national_dawn/Screens/MyOfferDetailScreen.dart';
import 'package:the_national_dawn/Screens/NetworkScreen.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';
import 'package:the_national_dawn/Screens/NotificationDilog.dart';
import 'package:the_national_dawn/Screens/NotificationInquiry.dart';
import 'package:the_national_dawn/Screens/NotificationPopUp.dart';
import 'package:the_national_dawn/Screens/NotificationScreen.dart';
import 'package:the_national_dawn/Screens/OfferDetailScreen.dart';
import 'package:the_national_dawn/Screens/OfferScreen.dart';
import 'package:the_national_dawn/Screens/OneTwoOneScreen.dart';
import 'package:the_national_dawn/Screens/PopularNewsScreen.dart';
import 'package:the_national_dawn/Screens/ProfileScreen.dart';
import 'package:the_national_dawn/Screens/ReferEarnScreen.dart';
import 'package:the_national_dawn/Screens/RegisterScreen.dart';
import 'package:the_national_dawn/Screens/RegistrationProfileScreen.dart';
import 'package:the_national_dawn/Screens/RequestScreen.dart';
import 'package:the_national_dawn/Screens/SplashScreen.dart';
import 'package:the_national_dawn/Screens/StoriesScreen.dart';
import 'package:the_national_dawn/Screens/UpdateProfileScreen.dart';
import 'package:the_national_dawn/Screens/VerificationScreen.dart';
import 'package:the_national_dawn/Screens/ViewDetailScreen.dart';

import 'DigitalScreens/GalleryScreen.dart';
import 'GuestScreens/GridScreen.dart';
import 'GuestScreens/GuestBannerScreen.dart';
import 'GuestScreens/GuestCategoryNews.dart';
import 'GuestScreens/GuestDashBoard.dart';
import 'GuestScreens/GuestHome.dart';
import 'GuestScreens/GuestLatestNews.dart';
import 'GuestScreens/GuestProfile.dart';
import 'GuestScreens/GuestSearchScreen.dart';
import 'GuestScreens/VideoScreen.dart';
import 'Screens/AddOfferScreen.dart';
import 'Screens/CompleteScreen.dart';
import 'Screens/DailyNewsDashBoard.dart';
import 'Screens/EPaperScreen.dart';
import 'Screens/EnquiryForm.dart';
import 'Screens/MyOfferScreen.dart';
import 'Dealbox/OfferPage.dart';
import 'Screens/PermissionNoti.dart';

const debug = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FlutterDownloader.initialize(debug: debug);
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (message["data"]["status"] == "requested") {
          Get.to(NotificationPopUp(message: message));
          print("onMessage  (requested) $message");
        } else if (message["data"]["status"] == "inquiry") {
          Get.to(NotificationInquiry(message: message));
          print("onMessage  (requested) $message");
        } else {
          Get.to(NotificationDilog(message: message));
          print("onMessage (${message["data"]["status"]}): $message");
        }
      },
      //when app is closed and user click on notification
      onLaunch: (Map<String, dynamic> message) async {
        if (message["data"]["status"] == "requested") {
          Get.to(NotificationPopUp(message: message));
          print("onLaunch: $message");
        } else if (message["data"]["status"] == "inquiry") {
          Get.to(NotificationInquiry(message: message));
          print("onMessage  (requested) $message");
        } else {
          Get.to(NotificationDilog(message: message));
          print("onLaunch: $message");
        }
      },
      //when app is in background and user click on notification
      onResume: (Map<String, dynamic> message) async {
        log("onResume:------------------- $message  --------------------------------");
        if (message["data"]["status"] == "requested") {
          Get.to(NotificationPopUp(message: message));
          print("onResume: $message");
        } else if (message["data"]["status"] == "inquiry") {
          Get.to(NotificationInquiry(message: message));
          print("onMessage  (requested) $message");
        } else {
          Get.to(NotificationDilog(message: message));
          print("onResume: $message");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TND',
      initialRoute: '/',
      navigatorKey: Get.key,
      routes: {
        //'/': (context) => AddressScreen(),
        '/': (context) => SplashScreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/RegisterScreen': (context) => RegisterScreen(),
        '/VerificationScreen': (context) => VerificationScreen(),
        '/HomePage': (context) => HomePage(),
        '/HomeScreen': (context) => HomeScreen(),
        '/CalenderScreen': (context) => CalenderScreen(),
        '/CategoryScreen': (context) => CategoryScreen(),
        '/StoriesScreen': (context) => StoriesScreen(),
        '/OneTwoOneScreen': (context) => OneTwoOneScreen(),
        '/PaperScreen': (context) => PaperScreen(),
        '/DirectoryScreen': (context) => DirectoryScreen(),
        '/NetworkScreen': (context) => NetworkScreen(),
        '/DailyNewScreen': (context) => DailyNewScreen(),
        '/PopularNewsScreen': (context) => PopularNewsScreen(),
        '/ViewDetailScreen': (context) => ViewDetailScreen(),
        '/BookMarkScreen': (context) => BookMarkScreen(),
        '/OfferScreen': (context) => OfferScreen(),
        '/OfferDetailScreen': (context) => OfferDetailScreen(),
        '/ProfileScreen': (context) => ProfileScreen(),
        '/BusinessCardScreen': (context) => BusinessCardScreen(),
        '/HomeCategoryScreen': (context) => HomeCategoryScreen(),
        '/HomeCalendarScreen': (context) => HomeCalendarScreen(),
        '/HomeStoriesScreen': (context) => HomeStoriesScreen(),
        '/HomeNetworkScreen': (context) => HomeNetworkScreen(),
        '/BookMarkDetailScreen': (context) => BookMarkDetailScreen(),
        '/UpdateProfileScreen': (context) => UpdateProfileScreen(),
        '/CalendarDetailScreen': (context) => CalendarDetailScreen(),
        '/AddOfferScreen': (context) => AddOfferScreen(),
        '/ReferEarnScreen': (context) => ReferEarnScreen(),
        '/MyEcardScreen': (context) => MyEcardScreen(),
        '/NotificationScreen': (context) => NotificationScreen(),
        '/MyOfferScreen': (context) => MyOfferScreen(),
        '/MemberDetailScreen': (context) => MemberDetailScreen(),
        '/BussinessStoryScreen': (context) => BussinessStoryScreen(),
        '/NewsBannerDetail': (context) => NewsBannerDetail(),
        '/EventTicketScreen': (context) => EventTicketScreen(),
        '/RequestScreen': (context) => RequestScreen(),
        '/RegistrationProfileScreen': (context) => RegistrationProfileScreen(),
        '/NotificationPopUp': (context) => NotificationPopUp(),
        '/NotificationDilog': (context) => NotificationDilog(),
        '/MyOfferDetailScreen': (context) => MyOfferDetailScreen(),
        '/CompleteScreen': (context) => CompleteScreen(),
        '/DailyNewsDashBoard': (context) => DailyNewsDashBoard(),
        '/OfferPage': (context) => OfferPage(),
        '/PermissionNoti': (context) => PermissionNoti(),


        //===============digital card screen=============
        '/AddCard': (context) => AddCard(),
        '/ChangeTheme': (context) => ChangeTheme(),
        '/Dashboard': (context) => Dashboard(),
        '/EditOffer': (context) => EditOffer(),
        '/EditService': (context) => EditService(),
        '/Home': (context) => Home(),
        '/More': (context) => More(),
        '/OfferDetail': (context) => OfferDetail(),
        '/Offers': (context) => Offers(),
        '/MemberServices': (context) => MemberServices(),
        '/ShareHistory': (context) => ShareHistory(),
        '/ProfileDetail': (context) => ProfileDetail(),
        '/AddService': (context) => AddService(),
        '/AddOffer': (context) => AddOffer(),
        '/EnquiryForm': (context) => EnquiryForm(),
        '/GalleryScreen': (context) => GalleryScreen(),

        //=============Guest Login
        '/GuestDashBoard': (context) => GuestDashBoard(),
        '/GridScreen': (context) => GridScreen(),
        '/GuestBannerScreen': (context) => GuestBannerScreen(),
        '/GuestHome': (context) => GuestHome(),
        '/GuestLatestNews': (context) => GuestLatestNews(),
        '/GuestProfile': (context) => GuestProfile(),
        '/GuestSearchScreen': (context) => GuestSearchScreen(),
        '/GuestCategoryNews': (context) => GuestCategoryNews(),
        '/VideoScreen': (context) => VideoScreen(),
      },
      theme: ThemeData(
          //fontFamily: 'RobotoSlab',
          // primarySwatch: cnst.appPrimaryMaterialColor,
//        accentColor: Colors.black,
//        buttonColor: Colors.deepPurple,
          ),
    );
  }
}
