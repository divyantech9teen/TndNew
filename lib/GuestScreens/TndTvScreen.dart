import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'VideoScreen.dart';
import 'dart:convert';
import 'ViewAllScreen.dart';
import 'package:flutter/services.dart';

class TndTvScreen extends StatefulWidget {
  @override
  _TndTvScreenState createState() => _TndTvScreenState();
}

class _TndTvScreenState extends State<TndTvScreen> {
  bool isload = true;
  var data;
  var url;
  var response;

  Future fetchdata() async {
    url = "http://15.207.46.236/admin/youtube_video_list";
    response = await http.post(url);
    setState(() {
      data = json.decode(response.body);
      print(data["Data"][1]["publishedAt"]);
    });
    setState(() {
      isload = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 0,
        title: FittedBox(
          child: Text(
            "TND Tv",
            style: TextStyle(
                color: appPrimaryMaterialColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      body: isload
          ? LoadingBlueComponent()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TRENDING",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllScreen()));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 18,
                                color: appPrimaryMaterialColor,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 220,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoScreen(
                                          ytlink: data["Data"][index]
                                              ["videoId"]),
                                    ));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, top: 0.0, bottom: 6.0),
                                  child: Container(
                                    height: 180,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[200],

                                        //width: 8,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Container(
                                                height: 154,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.3,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://img.youtube.com/vi/${data["Data"][index]["videoId"]}/0.jpg"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.grey[200],
                                                    //width: 8,
                                                  ),
                                                ),
                                                child: Container()
                                                // widget.newsData[index]
                                                // ['featured_img_src'] ==
                                                // null
                                                // ?
                                                // Image.asset('assets/LOGO1.png')
                                                //     : Image.network(
                                                // widget.newsData[index]
                                                // ['featured_img_src'],
                                                //
                                                // fit: BoxFit.fill,
                                                //
                                                // )
                                                ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(8.0),
                                            //   child: Container(
                                            //     color: Colors.black54
                                            //         .withOpacity(0.2),
                                            //     padding:
                                            //         const EdgeInsets.all(4.0),
                                            //      child:  Text(
                                            //       "1:20",
                                            //       style: TextStyle(
                                            //           color: Colors.white),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        Container(
                                          //color: Colors.black54.withOpacity(0.3),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              // "${widget.newsData[index]["title"]}",
                                              "${data["Data"][index]["title"]}",
                                              overflow: TextOverflow.ellipsis,

                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: GridView.builder(
                        itemCount: data["Data"].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 3.0, left: 3.0, right: 3.0, top: 3),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoScreen(
                                          ytlink: data["Data"][index]
                                          ["videoId"]),
                                    ));
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[200],
                                    //width: 8,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://img.youtube.com/vi/${data["Data"][index]["videoId"]}/0.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 130,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          // borderRadius: BorderRadius.circular(8.0),
                                          child:
                                              // searchlist[index][
                                              // 'categoryImage'] ==
                                              //     null
                                              //     ?
                                              Container(
                                        height: 130,
                                      )
                                          //     : Image.network(
                                          //   Image_URL +
                                          //       searchlist[index][
                                          //       'categoryImage'],
                                          //   width: MediaQuery.of(
                                          //       context)
                                          //       .size
                                          //       .width,
                                          //   height: MediaQuery.of(
                                          //       context)
                                          //       .size
                                          //       .height,
                                          //   fit: BoxFit.fill,
                                          // )
                                          ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        // height: 50,
                                        child: Text(
                                          "${data["Data"][index]["title"]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
