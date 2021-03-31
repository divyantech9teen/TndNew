import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Screens/OfferDetailScreen.dart';

class OfferComponent extends StatefulWidget {
  var offerData;

  OfferComponent({this.offerData});

  @override
  _OfferComponentState createState() => _OfferComponentState();
}

class _OfferComponentState extends State<OfferComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OfferDetailScreen(
                            offerData: widget.offerData,
                          )));
            },
            child: Container(
              height: 179,
              width: MediaQuery.of(context).size.width,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  //"assets/10.jpeg",
                  "${widget.offerData["bannerImage"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              height: 24,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0)),
                color: appPrimaryMaterialColor[300],
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(
                  //"Category",
                  "${widget.offerData["title"]}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              height: 24,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0)),
                color: appPrimaryMaterialColor[300],
                //color: ColorUtils.buttonDarkBlueColor,
              ),
              child: Center(
                  child: Text(
                "Expires on: " + "${widget.offerData["offerExpire"]}",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
