import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCardComponent extends StatefulWidget {
  var businessData;
  BusinessCardComponent({this.businessData});
  @override
  _BusinessCardComponentState createState() => _BusinessCardComponentState();
}

class _BusinessCardComponentState extends State<BusinessCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 22, left: 12, right: 12),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[100], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400].withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(3.0, 5.0))
            ]),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 210,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey[100]),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "${widget.businessData["img"]}",
//                    "assets/z.jpeg",
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.businessData["name"]}",
//                      "Arpit Shah",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        "${widget.businessData["company_name"]}",
                        //widget.directoryData["business_category"],
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          launch(('tel:// ${widget.businessData["mobile"]}'));
                        },
                        child: Container(
                          height: 25,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: appPrimaryMaterialColor[100], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset('assets/videocall.png'),
                              Icon(
                                Icons.call,
                                color: appPrimaryMaterialColor,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(
                                  "Call",
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _launchURL(widget.businessData["email"], '', '');
                        },
                        child: Container(
                          height: 25,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: appPrimaryMaterialColor[100], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
//                              Icon(
//                                Icons.more_vert,
//                                color: appPrimaryMaterialColor,
//                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Icon(
                                  Icons.mail,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
//
                              Text(
                                "Mail",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
