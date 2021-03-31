import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Screens/MyOfferDetailScreen.dart';

class MyOfferComponent extends StatefulWidget {
  var offerData;
  MyOfferComponent({this.offerData});
  @override
  _MyOfferComponentState createState() => _MyOfferComponentState();
}

class _MyOfferComponentState extends State<MyOfferComponent> {
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
                      builder: (context) => MyOfferDetailScreen(
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
                  //"assets/offer2.jpg",
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
                  // "Category",
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
                //"Expires on: " + "12/05/2020",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );

//       Padding(
//       padding: const EdgeInsets.only(left: 12.0, right: 12, top: 7),
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               /* Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => OfferDetailScreen(
//                         offerData: widget.offerData,
//                       )));*/
//             },
//             child: Container(
//               height: 199,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
// //                  color: Colors.white,
//                   border: Border.all(color: Colors.grey[100], width: 1),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey[400].withOpacity(0.2),
//                         blurRadius: 1.0,
//                         spreadRadius: 1.0,
//                         offset: Offset(3.0, 5.0))
//                   ]),
//               padding: EdgeInsets.only(bottom: 35),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   "assets/offer2.jpg",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 0.0,
//             left: 0.0,
//             child: Container(
//               height: 24,
//               width: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(12.0),
//                     topRight: Radius.circular(12.0),
//                     topLeft: Radius.circular(12.0)),
//                 color: appPrimaryMaterialColor[300],
//               ),
//               child: Center(
//                   child: Padding(
//                 padding: const EdgeInsets.only(left: 3.0),
//                 child: Text(
//                   "Category",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )),
//             ),
//           ),
//           Positioned(
//             bottom: 36.0,
//             right: 0.0,
//             child: Container(
//               height: 24,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(12.0),
//                     topLeft: Radius.circular(12.0)),
//                 color: appPrimaryMaterialColor[300],
//                 //color: ColorUtils.buttonDarkBlueColor,
//               ),
//               child: Center(
//                   child: Text(
//                 // "Expires on: " + "${widget.offerData["offerExpire"]}",
//                 "Expires on: " + "12/05/2020",
//                 style: TextStyle(color: Colors.white),
//               )),
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 height: 20,
//                 width: 40,
//                 decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     border: Border.all(color: Colors.grey[200], width: 1),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey[600].withOpacity(0.2),
//                           blurRadius: 1.0,
//                           spreadRadius: 1.0,
//                           offset: Offset(3.0, 5.0))
//                     ]),
//                 child: Icon(
//                   Icons.arrow_back_ios_outlined,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
  }
}
