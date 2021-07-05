import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class ViewAllScreen extends StatefulWidget {
  @override
  _ViewAllScreenState createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
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
      body: ListView.builder(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  // builder: (context) => NewsBannerDetail(
                  // newsData: widget.newsData[index],
                  // ),
                  // ));
                },
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 6.0, top: 6.0, bottom: 6.0),
                    child: Container(
                      //  height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[200],
                          //width: 8,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                  height: 170,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[200],
                                      //width: 8,
                                    ),
                                  ),
                                  child: Container(
                                    color: appPrimaryMaterialColor[400],
                                  )
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.black54.withOpacity(0.2),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "1:20",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            //color: Colors.black54.withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                // "${widget.newsData[index]["title"]}",
                                "Ahead of the Tamil Nadu assembly election, DMK chief MK Stalin has said loans taken by women self-help groups from cooperative banks will be waived off once the party comes to power.",
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
    );
  }
}
