import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/EpaperComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';

class PaperScreen extends StatefulWidget {
  @override
  _PaperScreenState createState() => _PaperScreenState();
}

class _PaperScreenState extends State<PaperScreen> {
  List getEpaperList = [];
  bool isLoading = true;
  bool isCatlogLoading = false;
  String formatDatee;
  List searchlist = new List();
  bool _isSearching = false, isfirst = false;
  @override
  void initState() {
    _getEpaper();
  }

  Future<File> createFileOfPdfUrl(url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    setState(() {
      isCatlogLoading = true;
    });
    try {
      //final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      setState(() {
        isCatlogLoading = false;
      });
    } catch (e) {
      setState(() {
        isCatlogLoading = false;
      });
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  var _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            "E-Paper ",
            style: TextStyle(
              color: appPrimaryMaterialColor,
              fontSize: 18,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.day,
              ).then((value) {
                if (value == null) {
                  print("not working");
                } else {
                  setState(() {
                    _selectedDate = value;
                    formatDatee =
                        DateFormat('dd/MM/yyyy').format(_selectedDate);
                  });
                  searchOperation(formatDatee);
                  print(" working ... " +
                      DateFormat('dd/MM/yyyy').format(_selectedDate));
                  print(" working  ${formatDatee}");
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  Icons.filter_alt,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
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
      body: isLoading == true
          ? LoadingBlueComponent()
          : getEpaperList.length > 0 && getEpaperList != null
              ? isfirst && searchlist.length == 0
                  ? GridView.builder(
                      physics: BouncingScrollPhysics(),
                      // shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      itemCount: getEpaperList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    log(getEpaperList[index]["pdfUrl"]);
                                    if (getEpaperList[index]["pdfUrl"] != "") {
                                      await createFileOfPdfUrl(
                                              "http://15.207.46.236/" +
                                                  getEpaperList[index]
                                                      ["pdfUrl"])
                                          .then((f) {
                                        log(f.path);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new EpaperComponent(
                                              path: f.path,
                                              ePaperData: getEpaperList[index]
                                                  ["pdfUrl"],
                                            ),
                                          ),
                                        );
                                      });
                                    } else
                                      Fluttertoast.showToast(
                                          msg: "Data not found");
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => EpaperComponent(
                                    //               ePaperData:
                                    //                   getEpaperList[index],
                                    //             )));
                                  },
                                  child: Container(
                                    height: 179,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey[100], width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400]
                                                  .withOpacity(0.2),
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(3.0, 5.0))
                                        ]),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: PDF.network(
                                          "http://15.207.46.236/" +
                                              getEpaperList[index]["pdfUrl"],
                                        )),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: InkWell(
                                    onTap: () async {
                                      log(getEpaperList[index]["pdfUrl"]);
                                      if (getEpaperList[index]["pdfUrl"] !=
                                          "") {
                                        await createFileOfPdfUrl(
                                                "http://15.207.46.236/" +
                                                    getEpaperList[index]
                                                        ["pdfUrl"])
                                            .then((f) {
                                          log(f.path);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new EpaperComponent(
                                                path: f.path,
                                                ePaperData: getEpaperList[index]
                                                    ["pdfUrl"],
                                              ),
                                            ),
                                          );
                                        });
                                      } else
                                        Fluttertoast.showToast(
                                            msg: "Data not found");
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => EpaperComponent(
                                      //               ePaperData:
                                      //                   getEpaperList[index],
                                      //             )));
                                    },
                                    child: Container(
                                      height: 24,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12.0),
                                            topLeft: Radius.circular(12.0)),
                                        color: Colors.blue,
                                        //color: ColorUtils.buttonDarkBlueColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${getEpaperList[index]["title"]} ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      },
                    )
                  : searchlist.length != 0
                      ? GridView.builder(
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemCount: searchlist.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 179,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey[100],
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[400]
                                                      .withOpacity(0.2),
                                                  blurRadius: 1.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(3.0, 5.0))
                                            ]),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: PDF.network(
                                              "http://15.207.46.236/" +
                                                  searchlist[index]["pdfUrl"],
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: InkWell(
                                        onTap: () async {
                                          log(searchlist[index]["pdfUrl"]);
                                          if (searchlist[index]["pdfUrl"] !=
                                              "") {
                                            await createFileOfPdfUrl(
                                                    "http://15.207.46.236/" +
                                                        searchlist[index]
                                                            ["pdfUrl"])
                                                .then((f) {
                                              log(f.path);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new EpaperComponent(
                                                    path: f.path,
                                                    ePaperData:
                                                        searchlist[index]
                                                            ["pdfUrl"],
                                                  ),
                                                ),
                                              );
                                            });
                                          } else
                                            Fluttertoast.showToast(
                                                msg: "Data not found");
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => EpaperComponent(
                                          //               ePaperData:
                                          //                   getEpaperList[index],
                                          //             )));
                                        },
                                        child: Container(
                                          height: 24,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(12.0),
                                                topLeft: Radius.circular(12.0)),
                                            color: Colors.blue,
                                            //color: ColorUtils.buttonDarkBlueColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${searchlist[index]["title"]} ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        )
                      : GridView.builder(
                          physics: BouncingScrollPhysics(),
                          // shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          itemCount: getEpaperList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        log(getEpaperList[index]["pdfUrl"]);
                                        if (getEpaperList[index]["pdfUrl"] !=
                                            "") {
                                          await createFileOfPdfUrl(
                                                  "http://15.207.46.236/" +
                                                      getEpaperList[index]
                                                          ["pdfUrl"])
                                              .then((f) {
                                            log(f.path);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new EpaperComponent(
                                                  path: f.path,
                                                  ePaperData:
                                                      getEpaperList[index]
                                                          ["pdfUrl"],
                                                ),
                                              ),
                                            );
                                          });
                                        } else
                                          Fluttertoast.showToast(
                                              msg: "Data not found");
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) => EpaperComponent(
                                        //               ePaperData:
                                        //                   getEpaperList[index],
                                        //             )));
                                      },
                                      child: Container(
                                        height: 179,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.grey[100],
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[400]
                                                      .withOpacity(0.2),
                                                  blurRadius: 1.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(3.0, 5.0))
                                            ]),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: PDF.network(
                                              "http://15.207.46.236/" +
                                                  getEpaperList[index]
                                                      ["pdfUrl"],
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,
                                      right: 0.0,
                                      child: InkWell(
                                        onTap: () async {
                                          log(getEpaperList[index]["pdfUrl"]);
                                          if (getEpaperList[index]["pdfUrl"] !=
                                              "") {
                                            await createFileOfPdfUrl(
                                                    "http://15.207.46.236/" +
                                                        getEpaperList[index]
                                                            ["pdfUrl"])
                                                .then((f) {
                                              log(f.path);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new EpaperComponent(
                                                    path: f.path,
                                                    ePaperData:
                                                        getEpaperList[index]
                                                            ["pdfUrl"],
                                                  ),
                                                ),
                                              );
                                            });
                                          } else
                                            Fluttertoast.showToast(
                                                msg: "Data not found");
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => EpaperComponent(
                                          //               ePaperData:
                                          //                   getEpaperList[index],
                                          //             )));
                                        },
                                        child: Container(
                                          height: 24,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(12.0),
                                                  topLeft:
                                                      Radius.circular(12.0)),
                                              color: Colors.blue
                                              //color: ColorUtils.buttonDarkBlueColor,
                                              ),
                                          child: Center(
                                            child: Text(
                                              "${getEpaperList[index]["title"]}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        )
              : Center(
                  child: Container(
                    //color: Color.fromRGBO(0, 0, 0, 0.6),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("No Data Available",
                        style: TextStyle(
                            fontSize: 20, color: appPrimaryMaterialColor)),
                  ),
                ),
    );
  }

  void searchOperation(String searchText) {
    log('===========0================');
    searchlist.clear();
    if (_isSearching != null) {
      isfirst = true;
      log('===========1================');
      print(getEpaperList[0]["date"]);
      for (int i = 0; i < getEpaperList.length; i++) {
        print(getEpaperList.length);
        String newstype = getEpaperList[i]["date"].toString();
        log('===========2================');
        if (newstype.toLowerCase().contains(searchText.toLowerCase())) {
          searchlist.add(getEpaperList[i]);
          log('===========3================');
        }
      }
    }
    setState(() {});
  }

  _getEpaper() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.PostForList(api_name: 'admin/getEpaper').then(
            (ResponseList) async {
          setState(() {
            isLoading = false;
          });
          if (ResponseList.length > 0) {
            setState(() {
              getEpaperList = ResponseList;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "No Data Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
