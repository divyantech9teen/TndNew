import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Screens/NewsBannerDetail.dart';

class GuestSearchComponent extends StatefulWidget {
  var newsData;

  GuestSearchComponent({this.newsData});

  @override
  _GuestSearchComponentState createState() => _GuestSearchComponentState();
}

class _GuestSearchComponentState extends State<GuestSearchComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
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
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                // borderRadius: BorderRadius.circular(8.0),
                child: widget.newsData['featured_img_src'] == null
                    ? Container(
                        color: appPrimaryMaterialColor[400],
                      )
                    : Image.network(
                        widget.newsData['featured_img_src'],
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.fill,
                      )),
          ),
          Positioned(
              //top: 10,
              child: Container(
            color: Colors.black12.withOpacity(0.4),
            //  height: 30,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.newsData["title"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
          ))
        ]),
      ),
    );
  }
}
