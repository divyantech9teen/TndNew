import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class BookMarkDetailScreen extends StatefulWidget {
  var bookmarkData;

  BookMarkDetailScreen({this.bookmarkData});

  @override
  _BookMarkDetailScreenState createState() => _BookMarkDetailScreenState();
}

class _BookMarkDetailScreenState extends State<BookMarkDetailScreen> {
  String parsedString;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  // "${widget.newsData["content"]}"

  @override
  void initState() {
    _parseHtmlString("${widget.bookmarkData["content"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  size: 30.0,
                )),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(
                "http://www.thenationaldawn.in/${widget.bookmarkData["slug"]}",
                // subject: subject,
                // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    Icons.share,
                    color: Colors.black,
                    size: 30.0,
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/TND Logo_PNG_Newspaper.png",
                fit: BoxFit.contain,
                image: "${widget.bookmarkData["featured_img_src"]}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${widget.bookmarkData["title"]}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${parsedString}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Color(0xff010101),
                            fontSize: 14,
                            letterSpacing: 0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
