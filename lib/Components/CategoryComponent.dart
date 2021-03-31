import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Components/SubCategoryComponent.dart';

class CategoryComponent extends StatefulWidget {
  var CatData;
  CategoryComponent({this.CatData});
  @override
  _CategoryComponentState createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  String isMember = "";

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //print(widget.catData["memberOf"]);
  // }
  @override
  void initState() {
    setState(() {
      _profile();
    });
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isMember = prefs.getString(Session.ismember);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new SubCategoryComponent(
                      catData: widget.CatData,
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
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "${widget.CatData["categoryImage"]}",
                      fit: BoxFit.cover,
                    )),
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
                "${widget.CatData["categoryName"]}",
                style: TextStyle(color: Colors.black, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
