import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Components/DirectoryComponent.dart';

class GridDirectoryComponent extends StatefulWidget {
  var directData;
  GridDirectoryComponent({this.directData});
  @override
  _GridDirectoryComponentState createState() => _GridDirectoryComponentState();
}

class _GridDirectoryComponentState extends State<GridDirectoryComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new DirectoryComponent(
                      //  catData: widget.CatData,
                      directoryData: widget.directData,
                    )));
      },
      child: Container(
        height: 140,
        margin: EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: appPrimaryMaterialColor[100], width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            boxShadow: [
              BoxShadow(
                  color: appPrimaryMaterialColor.withOpacity(0.2),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(3.0, 5.0))
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[200], width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Icon(Icons.add)

                  // ClipRRect(
                  //     borderRadius: BorderRadius.circular(20),
                  //     child: Image.network(
                  //       "${widget.directData["img"]}",
                  //       fit: BoxFit.cover,
                  //     )),
                  ),
//            Icon(
//              Icons.image,
//              color: Colors.grey,
//              size: 74,
//            ),
              SizedBox(
                height: 10,
              ),
              Text(
                "abc",
                // "${widget.directData["business_category"]["categoryName"]}",
                style: TextStyle(color: Colors.black, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
