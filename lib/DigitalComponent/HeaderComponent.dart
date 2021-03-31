import 'package:flutter/material.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

class HeaderComponent extends StatelessWidget {
  final String title;
  final String image;
  final double boxheight;

  const HeaderComponent(
      {this.title,
      this.image = "images/header/moreheader.jpg",
      this.boxheight = 100.00});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
          height: boxheight,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Image.asset(image,
                  width: MediaQuery.of(context).size.width,
                  height: boxheight,
                  fit: BoxFit.cover),
              Container(
                margin: EdgeInsets.only(top: 40, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
            ],
          )),
      clipper: headerClipper(),
    );
  }
}

class headerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
