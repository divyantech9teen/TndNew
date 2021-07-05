import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaComponent extends StatefulWidget {
  String instagram, facebook, linkedIn, twitter, whatsapp, mail, youtube;

  SocialMediaComponent({
    this.instagram,
    this.facebook,
    this.linkedIn,
    this.twitter,
    this.whatsapp,
    this.mail,
    this.youtube,
  });

  @override
  _SocialMediaComponentState createState() => _SocialMediaComponentState();
}

class _SocialMediaComponentState extends State<SocialMediaComponent> {
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

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          widget.instagram == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    launchSocialMediaUrl(widget.instagram);
                  },
                  child: Image.asset('assets/instagram.png',
                      width: 30, height: 30)),
          widget.facebook == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    launchSocialMediaUrl(widget.facebook);
                  },
                  child: Image.asset('assets/facebook.png',
                      width: 30, height: 30)),
          widget.linkedIn == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    launchSocialMediaUrl(widget.linkedIn);
                  },
                  child: Image.asset('assets/linkedin.png',
                      width: 30, height: 30)),
          widget.twitter == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    launchSocialMediaUrl(widget.twitter);
                  },
                  child:
                      Image.asset('assets/twitter.png', width: 30, height: 30)),
          widget.whatsapp == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    launchwhatsapp(phone: "+91" + widget.whatsapp, message: "");
                  },
                  child: Image.asset('assets/whatsapp2.png',
                      width: 30, height: 30)),
          widget.mail == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    _launchURL(widget.mail, '', '');
                  },
                  child:
                      Image.asset('assets/gmail.png', width: 30, height: 30)),
          widget.youtube == ""
              ? Container()
              : GestureDetector(
                  onTap: () {
                    launchSocialMediaUrl(widget.youtube);
                  },
                  child: Image.asset('assets/yout.png', width: 30, height: 30)),
        ],
      ),
    );
  }
}
