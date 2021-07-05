import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';

class GuestCategoryNewsComponent extends StatefulWidget {
  var newsData;

  GuestCategoryNewsComponent({this.newsData});

  @override
  _GuestCategoryNewsComponentState createState() =>
      _GuestCategoryNewsComponentState();
}

class _GuestCategoryNewsComponentState
    extends State<GuestCategoryNewsComponent> {
  String parsedString;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  // "${widget.newsData["content"]}"

  @override
  void initState() {
    _parseHtmlString("${widget.newsData["content"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsBannerDetail(
                  newsData: widget.newsData,
                ),
              ));
        },
        child: Container(
          height: 130,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, top: 15.0, right: 5),
                      child: Text(
                        "${widget.newsData["title"]}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5.0, top: 0.0, right: 5),
                      child: Text(
                        "${parsedString}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            //  fontWeight: FontWeight.w500,
                            letterSpacing: 0.4),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                  height: 300,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          child: widget.newsData['featured_img_src'] == null
                              ? Container(
                                  color: appPrimaryMaterialColor[100],
                                  child: Center(
                                      child: Image.asset(
                                    'assets/appLogo.png',
                                    width: 150,
                                    height: 300,
                                  )),
                                )
                              : Image.network(
                                  widget.newsData['featured_img_src'],
                                  width: 150,
                                  height: 300,

                                  // height: 220,
                                  fit: BoxFit.fill,
                                )),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                            "http://www.thenationaldawn.in/${widget.newsData["slug"]}",
                            // subject: subject,
                            // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              color: Colors.white.withOpacity(0.4),
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.share,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
