import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/Common/Services.dart';
import 'package:the_national_dawn/Components/EpaperComponent.dart';
import 'package:the_national_dawn/Components/LoadingBlueComponent.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class PaperScreen extends StatefulWidget {
  @override
  _PaperScreenState createState() => _PaperScreenState();
}

class _PaperScreenState extends State<PaperScreen> {
  List getEpaperList = [];
  bool isLoading = true;
  bool isCatlogLoading = false;

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
          : getEpaperList.length > 0
              ? ListView.builder(
                  itemCount: getEpaperList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  log(getEpaperList[index]["pdfUrl"]);
                                  if (getEpaperList[index]["pdfUrl"] != "") {
                                    await createFileOfPdfUrl(
                                            "http://15.207.46.236/" +
                                                getEpaperList[index]["pdfUrl"])
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
                                    child: Image.network(
                                      "http://15.207.46.236/" +
                                          "${getEpaperList[index]["image"]}",

                                      //"assets/offer2.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                left: 0.0,
                                child: Container(
                                  height: 24,
                                  // width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                        topLeft: Radius.circular(12.0)),
                                    color: appPrimaryMaterialColor[300],
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3),
                                    child: Text(
                                      "${getEpaperList[index]["title"]} ",

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
                                    "On Date: " +
                                        "${getEpaperList[index]["date"]}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                )
              : Center(child: Text("No Data Found...!")),
    );
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
