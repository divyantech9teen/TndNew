import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';

class GuestLatestNews extends StatefulWidget {
  var newsData;

  GuestLatestNews({this.newsData});

  @override
  _GuestLatestNewsState createState() => _GuestLatestNewsState();
}

class _GuestLatestNewsState extends State<GuestLatestNews> {
  String parsedString;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  void initState() {
    _parseHtmlString("${widget.newsData["content"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: widget.newsData['featured_img_src'] == null
                      ? Image.asset('assets/appLogo.png')
                      : Image.network(
                          widget.newsData['featured_img_src'],
                          //width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.fill,
                          // color: Color.fromRGBO(255, 255, 255, 0.5),
                          // colorBlendMode: BlendMode.colorDodge
                        )),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.newsData["title"]}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.newsData["Category"]}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${parsedString}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  maxLines: 05,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
