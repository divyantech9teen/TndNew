import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/ClassList.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Components/MyEcardComponent.dart';
import 'package:the_national_dawn/offlineDatabase/db_handler.dart';

class MyEcardScreen extends StatefulWidget {
  @override
  _MyEcardScreenState createState() => _MyEcardScreenState();
}

class _MyEcardScreenState extends State<MyEcardScreen> {
  DBHelper dbHelper;
  Future<List<Visitorclass>> visitor;
  List visitordata = [];

  @override
  void initState() {
    refresh();
  }

  refresh() async {
    dbHelper = new DBHelper();
    Future res = dbHelper.getVisitors();
    res.then((data) async {
      setState(() {
        visitordata = data;
      });
      print(data.toString());
    }, onError: (e) {});
  }

  void deleteCard(int id) async {
    int result = await dbHelper.delete(id);
    if (result != 0) {
      refresh();
    }
  }

  _delete(var id) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Are you sure want to Delete?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: appPrimaryMaterialColor),
              ),
              onPressed: () async {
                deleteCard(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "My Scan Card",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontSize: 18,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        leading: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
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
              ),
            ),
          ),
        ),
      ),
      body: visitordata.length > 0
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: visitordata.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 5, left: 12, right: 12),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 1.2,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          decoration: BoxDecoration(
                              color: appPrimaryMaterialColor[300],
                              border:
                                  Border.all(color: Colors.grey[100], width: 1),
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
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                Image_URL + "${visitordata[index].Image}",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${visitordata[index].Name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 9.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // deleteCard(visitordata[index].id);
                                          _delete(visitordata[index].id);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    "${visitordata[index].Company_Name}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    "${visitordata[index].Phone}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: FittedBox(
                                    child: Text(
                                      "${visitordata[index].Email}",
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                "No Data Found",
                style: TextStyle(fontSize: 18, color: appPrimaryMaterialColor),
              ),
            ),
    );
  }
}
