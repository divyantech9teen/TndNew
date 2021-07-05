import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/main.dart';

class EpaperComponent extends StatefulWidget {
  var ePaperData, path;
  EpaperComponent({this.ePaperData, this.path});
  @override
  _EpaperComponentState createState() => _EpaperComponentState();
}

class _EpaperComponentState extends State<EpaperComponent> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  var URL;
  bool _permissionReady;

  // List<_TaskInfo> _tasks;
  ReceivePort _port = ReceivePort();
  String _localPath;

  @override
  void initState() {
    log(widget.path);
    URL = "http://15.207.46.236/" + widget.ePaperData;
    log(URL);
    _permissionReady = false;
    //localFun();

    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  localFun() async {
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _requestDownload() async {
    String _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    log(_localPath);
    await FlutterDownloader.enqueue(
      url: URL,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
    ).then((value) {
      Fluttertoast.showToast(msg: "Pdf Downloaded Successfully!");
    });
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, right: 10, left: 10, bottom: 8),
              child: GestureDetector(
                onTap: () {
                  _requestDownload();
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
                    Icons.file_download,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: PDFView(
          filePath: widget.path,
          enableSwipe: true,
          autoSpacing: false,
          pageFling: false,
          onRender: (_pages) {
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (int page, int total) {
            print('page change: $page/$total');
          },
        )
        // SingleChildScrollView(
        //     child: Column(children: [
        //   SizedBox(
        //     height: MediaQuery.of(context).padding.top + 2,
        //   ),
        //   Container(
        //     child: Stack(
        //       alignment: Alignment.bottomCenter,
        //       children: [
        //         Container(
        //           //   height: 420,
        //           width: MediaQuery.of(context).size.width,
        //           child: FadeInImage.assetNetwork(
        //             placeholder: "assets/TND Logo_PNG_Newspaper.png",
        //             fit: BoxFit.contain,
        //             image: "http://15.207.46.236/" +
        //                 "${widget.ePaperData["image"]}",
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
        //     child: Container(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           SizedBox(
        //             height: 5,
        //           ),
        //           widget.ePaperData["date"] == null ||
        //                   widget.ePaperData["newsDate"] == ""
        //               ? Container()
        //               : Row(
        //                   // crossAxisAlignment: CrossAxisAlignment.start,
        //                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: <Widget>[
        //                     Icon(
        //                       Icons.timer,
        //                       size: 20,
        //                       color: Colors.grey,
        //                     ),
        //                     Text(
        //                       "${widget.ePaperData["date"]}",
        //                       style: TextStyle(color: Colors.grey, fontSize: 8),
        //                     )
        //                   ],
        //                 ),
        //           SizedBox(
        //             height: 5,
        //           ),
        //           Text("${widget.ePaperData["title"]}",
        //               textAlign: TextAlign.justify,
        //               style: TextStyle(
        //                   color: Color(0xff010101),
        //                   fontSize: 16,
        //                   letterSpacing: 0)),
        //         ],
        //       ),
        //     ),
        //   ),
        // ]))

        );
  }
}
