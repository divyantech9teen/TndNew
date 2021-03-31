import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_national_dawn/DigitalCommon/ClassList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:the_national_dawn/DigitalCommon/Constants.dart' as cnst;

class ShareHistoryComponent extends StatefulWidget {
  final ShareClass shareClass;
  final int index;

  const ShareHistoryComponent(this.shareClass, this.index);

  @override
  _ShareHistoryComponentState createState() => _ShareHistoryComponentState();
}

class _ShareHistoryComponentState extends State<ShareHistoryComponent> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  Future<PermissionStatus> _getContactPermission() async {
    // PermissionStatus permission = await PermissionHandler()
    //     .checkPermissionStatus(PermissionGroup.contacts);
    // if (permission != PermissionStatus.granted &&
    //     permission != PermissionStatus.disabled) {
    //   Map<PermissionGroup, PermissionStatus> permissionStatus =
    //       await PermissionHandler()
    //           .requestPermissions([PermissionGroup.contacts]);
    //   return permissionStatus[PermissionGroup.contacts] ??
    //       PermissionStatus.unknown;
    // } else {
    //   return permission;
    // }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.shareClass.Name.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  Text(widget.shareClass.MobileNo,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                ],
              ),
              Text(
                  "${widget.shareClass.Date.substring(0, 2)}, ${widget.shareClass.Date.substring(3, widget.shareClass.Date.length)}",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ],
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Call',
            color: Colors.green,
            icon: Icons.phone,
            onTap: () {
              launch("tel:" + widget.shareClass.MobileNo);
            },
          ),
          IconSlideAction(
            caption: 'Save',
            color: Colors.blue,
            icon: Icons.save,
            onTap: () async {
              PermissionStatus permissionStatus = await _getContactPermission();
              try {
                if (permissionStatus == PermissionStatus.granted) {
                  Item item =
                      Item(label: 'office', value: widget.shareClass.MobileNo);

                  Contact newContact = new Contact(
                      givenName: widget.shareClass.Name, phones: [item]);

                  await ContactsService.addContact(newContact);
                  Fluttertoast.showToast(
                      msg: "Contact saved to phone",
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT);
                } else {
                  _handleInvalidPermissions(permissionStatus);
                }
              } catch (ex) {
                print(ex.toString());
                if (ex.toString() ==
                    "PlatformException(PERMISSION_DENIED, Access to location data denied, null)") {
                  Fluttertoast.showToast(
                      msg:
                          "Access permission is denied by user. \nplease go to setting -> app -> digitalcard -> permission, and allow permission",
                      backgroundColor: Colors.yellow,
                      gravity: ToastGravity.TOP,
                      toastLength: Toast.LENGTH_LONG);
                }
              }
              ;
            },
          ),
        ],
      ),
    );
  }
}
/*return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 220,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(shareClass.Name,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: cnst.appcolor)),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(shareClass.MobileNo,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600])),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          launch("tel:" + shareClass.MobileNo);
                        },
                        child: Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          PermissionStatus permissionStatus =
                              await _getContactPermission();
                          try {
                            if (permissionStatus == PermissionStatus.granted) {
                              Item item = Item(
                                  label: 'office', value: shareClass.MobileNo);

                              Contact newContact = new Contact(
                                  givenName: shareClass.Name, phones: [item]);

                              await ContactsService.addContact(newContact);
                              Fluttertoast.showToast(
                                  msg: "Contact saved to phone",
                                  backgroundColor: Colors.green,
                                  gravity: ToastGravity.TOP,
                                  toastLength: Toast.LENGTH_SHORT);
                            } else {
                              _handleInvalidPermissions(permissionStatus);
                            }
                          } catch (ex) {
                            print(ex.toString());
                            if (ex.toString() ==
                                "PlatformException(PERMISSION_DENIED, Access to location data denied, null)") {
                              Fluttertoast.showToast(
                                  msg:
                                      "Access permission is denied by user. \nplease go to setting -> app -> digitalcard -> permission, and allow permission",
                                  backgroundColor: Colors.yellow,
                                  gravity: ToastGravity.TOP,
                                  toastLength: Toast.LENGTH_LONG);
                            }
                          }
                        },
                        child: Icon(
                          Icons.save,
                          size: 30,
                          color: Colors.blue,
                        ),
                        //child: Image.asset('images/icon_save.png',height: 25,width: 25,color: Colors.blue,),
                      ),
                    )
                  ],
                ),
                Container(
                    width: 92,
                    height: 60,
                    decoration: BoxDecoration(
                      color: cnst.buttoncolor,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(shareClass.Date.substring(0, 2),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                              shareClass.Date.substring(
                                  3, shareClass.Date.length),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );*/
