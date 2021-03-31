import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;
import 'package:the_national_dawn/DigitalCommon/Services.dart';
import 'package:video_player/video_player.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  File _Image;
  TextEditingController txtvideo = TextEditingController();
  // ignore: deprecated_member_use
  List<Asset> images = List<Asset>();
  bool isLoading = false;

  String _error = 'No Error Dectected';
  File file;
  String basename = "";
  List<String> filename;
  List files = [];
  List Video = [];
  int n = 0;
  bool video = false;

  //
  // getImageFileFromAsset(String path) async {
  //   File file = File(path);
  //   basename = file.path;
  //   filename = basename.split("/");
  //   n = filename.length;
  //   print(filename[n - 1]);
  //   return file;
  // }
  //
  // public String getImageFileFromAsset(Uri uri) {
  //   String[] projection = { MediaStore.Images.Media.DATA };
  //   Cursor cursor = managedQuery(uri, projection, null, null, null);
  //   startManagingCursor(cursor);
  //   int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
  //   cursor.moveToFirst();
  //   return cursor.getString(column_index);
  // }
  getImageFileFromAsset(String path) async {
    File file = File(path);
    basename = file.path;
    filename = basename.split("/");
    n = filename.length;
    print(filename[n - 1]);
    return file;
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //
  // Save() async {
  //   List files = [];
  //
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //
  //       // List<dynamic> multipart = List<dynamic>();
  //       // for (int i = 0; i < images.length; i++) {
  //       //   var path =
  //       //       await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
  //       //   print(path);
  //       //   multipart.add(
  //       //       await MultipartFile.fromFile(path, filename: images[i].name));
  //       //   print(images[i].name);
  //       // }
  //
  //       for (int i = 0; i < images.length; i++) {
  //         String filename = "";
  //         String filePath = "";
  //         String img = '';
  //         var data;
  //         File compressedFile;
  //         File _imageEvent = await File(images[i].identifier);
  //         print("inside for loop");
  //         print("${_imageEvent.path}");
  //         log("IMage wvwnt===${_imageEvent.path}");
  //         if (_imageEvent != null) {
  //           print(_imageEvent);
  //
  //           print('00');
  //           print(_imageEvent.path);
  //           var path2 =
  //               await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
  //           file = await getImageFileFromAsset(path2);
  //           List<int> imageBytes = await file.readAsBytesSync();
  //           String base64Image = base64Encode(imageBytes);
  //           img = base64Image;
  //           SharedPreferences prefs = await SharedPreferences.getInstance();
  //           data = {
  //             "memberid": prefs.getString(cnst.Session.MemberId),
  //             "images": files,
  //             "videos": _video
  //           };
  //           print("file123");
  //           print(file);
  //           Services.PostForList4(api_name: 'card/addimages', body: data).then(
  //                   (subCatResponseList) async {
  //                 setState(() {
  //                   isLoading = false;
  //                 });
  //                 if (subCatResponseList.length > 0) {
  //                   print("a1");
  //                   Fluttertoast.showToast(
  //                       msg: "Data Saved",
  //                       backgroundColor: Colors.green,
  //                       gravity: ToastGravity.TOP);
  //                   Navigator.popAndPushNamed(context, '/Dashboard');
  //                 } else {
  //                   print("a2");
  //                   Fluttertoast.showToast(
  //                       msg: "Data Not Saved",
  //                       backgroundColor: Colors.red,
  //                       gravity: ToastGravity.TOP,
  //                       toastLength: Toast.LENGTH_LONG);
  //                   //show "data not found" in dialog
  //                 }
  //               }, onError: (e) {
  //             setState(() {
  //               isLoading = false;
  //             });
  //             print("error on call -> ${e.message}");
  //             Fluttertoast.showToast(msg: "Something Went Wrong");
  //           });
  //         }
  //       } on SocketException catch (_) {
  //     Fluttertoast.showToast(msg: "No Internet Connection.");
  //   }
  //
  //           // compressedFile = await FlutterNativeImage.compressImage(
  //           //   _imageEvent.path,
  //           //   quality: 80,
  //           //   targetWidth: 600,
  //           //   targetHeight:
  //           //       (properties.height * 600 / properties.width).round(),
  //           // );
  //           // print(_imageEvent.path);
  //           // filename = _imageEvent.path.split('/').last;
  //           // filePath = compressedFile.path;
  //           // print(filePath);
  //           // print(compressedFile.path);
  //           // print("file path ===");
  //           // files.add((filePath != null && filePath != '')
  //           //     ? await MultipartFile.fromFile(filePath, filename: filename)
  //           //     : null);
  //           //
  //           // print(files.length);
  //           // log("file=====${files}");
  //
  //       }
  //
  //
  //       print("BOdddddddddddddddddddddddddddy");
  //
  // }
  chek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("MEMBER IDDDDDDDDDDDDDDDDDDDDDDDDDDDDD == " +
        prefs.getString(Session.digital_Id).toString());

    print("GGGGG MEMBER IDDDDDDDDDDDDDDDDDDDDDDDDDDDDD == " +
        prefs.getString("gMemberId").toString());
  }

  _uploadImages() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print("MEMBER IDDDDDDDDDDDDDDDDDDDDDDDDDDDDD" +
            prefs.getString(cnst.Session.MemberId).toString());
        var data;
        print("images");
        print(images);
        String img = '';

        for (int i = 0; i < images.length; i++) {
          ByteData byteData = await images[i].getByteData();
          List<int> imageData = byteData.buffer.asUint8List();
          MultipartFile multipartFile = MultipartFile.fromBytes(
            imageData,
            filename: images[i].name,
          );
          data = {
            "memberid": prefs.getString(cnst.Session.MemberId),
            "images": multipartFile,
          };
          // print(data);
          FormData formData = new FormData.fromMap(data);
          Services.PostForList4(api_name: 'card/addimages', body: formData)
              .then((data) async {
            print(
                "==================================================IMAGE UPLOAD SUCCESSFULLY==================================================");
            setState(() {
              isLoading = false;
            });
            showMsg("Image Uploded");
          }, onError: (e) {
            print(e.toString());
            showMsg("Try Again");
          });
        }
      }
    } on SocketException catch (_) {
      //pr.hide();
      showMsg("No Internet Connection.");
    }
  }

  _uploadVideo() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var data;
        String img = '';
        var links = txtvideo.text.split(",");
        print(" ====== links ====== ");
        print(links);

        for (int i = 0; i < links.length; i++) {
          data = {
            "memberid": prefs.getString(cnst.Session.MemberId),
            "videos": links[i],
          };
          // print(data);
          FormData formData = new FormData.fromMap(data);
          Services.PostForList4(api_name: 'card/addimages', body: formData)
              .then((data) async {
            print(
                "==================================================Video  UPLOAD SUCCESSFULLY==================================================");
            setState(() {
              isLoading = false;
            });
          }, onError: (e) {
            print(e.toString());
            showMsg("Try Again");
          });
        }
      }
    } on SocketException catch (_) {
      //pr.hide();
      showMsg("No Internet Connection.");
    }
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: appPrimaryMaterialColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
        // boxShadow: [
        //   BoxShadow(
        //       color: cnst.appPrimaryMaterialColor.withOpacity(0.2),
        //       blurRadius: 2.0,
        //       spreadRadius: 2.0,
        //       offset: Offset(3.0, 5.0))
        // ]
      ),
      child: images.length == 0
          ? InkWell(
              onTap: () {
                loadAssets();
              },
              child: Center(
                child: Text(
                  "Select Images",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          : ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(images.length, (index) {
                Asset asset = images[index];
                print("pick form galery");
                print(images[index].name.runtimeType);
                return AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                );
              }),
            ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      _error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

//for videoes
  File _video;
  File _cameraVideo;
  File bothVideo;
  ImagePicker picker = ImagePicker();

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

// This funcion will helps you to pick a Video File
  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);

    _video = File(pickedFile.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    _video = File(pickedFile.path);

    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        // _cameraVideoPlayerController.play();
        _videoPlayerController.play();
      });
  }

  void _VideoPopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () async {
                      _pickVideoFromCamera();

                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: new Icon(Icons.photo),
                    title: new Text('Gallery'),
                    onTap: () async {
                      _pickVideo();
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Gallery")),
      ),
      //bottomNavigationBar:
      body: SingleChildScrollView(
        child: isLoading == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 350,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      strokeWidth: 3,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  buildGridView(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: RaisedButton(
                        onPressed: () {},
                        color: cnst.buttoncolor,
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _uploadImages();
                              },
                              child: Container(
                                height: 20,
                                color: cnst.buttoncolor,
                                child: Center(
                                    child: Text(
                                  "Upload Images",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_video != null)
                    _videoPlayerController.value.initialized
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          )
                        : Container(),
                  SizedBox(
                    height: 75,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    child: Text(
                      "Note :- If You Want to insert multiple video link please insert ' , ' (Comma)  after each link",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: txtvideo,
                      style: TextStyle(fontSize: 15),
                      maxLines: 3,
                      cursorColor: appPrimaryMaterialColor,
                      validator: (phone) {},
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(
                            top: 1.0, bottom: 1, left: 5, right: 1),
                        hintText: "Enter your Video Link",
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500),
                        /* prefixIcon: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 15, left: 15, right: 15),
                                ),
                              ),*/
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: appPrimaryMaterialColor[400]),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: appPrimaryMaterialColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  // else
                  //   Text(
                  //     "Click on Pick Video to select video",
                  //     style: TextStyle(fontSize: 18.0),
                  //   ),
                  // RaisedButton(
                  //   onPressed: () {
                  //     // _pickVideo();
                  //     _VideoPopup(context);
                  //   },
                  //   child: Text("Pick Video From Gallery"),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: RaisedButton(
                        onPressed: () {
                          _uploadVideo();
                          // _VideoPopup(context);
                        },
                        color: cnst.buttoncolor,
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.video_call_rounded,
                              size: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Add Video",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // if (_cameraVideo != null)
                  //   _cameraVideoPlayerController.value.initialized
                  //       ? AspectRatio(
                  //           aspectRatio:
                  //               _cameraVideoPlayerController.value.aspectRatio,
                  //           child: VideoPlayer(_cameraVideoPlayerController),
                  //         )
                  //       : Container()
                  // else
                  //   Text(
                  //     "Click on Pick Video to select video",
                  //     style: TextStyle(fontSize: 18.0),
                  //   ),
                  // RaisedButton(
                  //   onPressed: () {
                  //     _pickVideoFromCamera();
                  //   },
                  //   child: Text("Pick Video From Camera"),
                  // ),
                ],
              ),
      ),
    );
  }
}
