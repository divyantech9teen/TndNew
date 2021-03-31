import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class MyEcardComponent extends StatefulWidget {
  var carddata;
  MyEcardComponent({this.carddata});

  @override
  _MyEcardComponentState createState() => _MyEcardComponentState();
}

class _MyEcardComponentState extends State<MyEcardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 22, left: 12, right: 12),
      child: Row(
        children: [
          Container(
              height: 110,
              width: 120,
              decoration: BoxDecoration(
                  color: appPrimaryMaterialColor[300],
                  border: Border.all(color: Colors.grey[100], width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400].withOpacity(0.2),
                        blurRadius: 1.0,
                        spreadRadius: 1.0,
                        offset: Offset(3.0, 5.0))
                  ]),
              child: Image.network(Image_URL + "${widget.carddata["Image"]}")),
          Container(
            height: 110,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[100], width: 1),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400].withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: Offset(3.0, 5.0))
                ]),
          ),
        ],
      ),
    );
  }
}
//ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child:Icon(Icons.person),
//             ),
