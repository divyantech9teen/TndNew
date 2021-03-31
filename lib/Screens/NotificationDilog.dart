import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class NotificationDilog extends StatefulWidget {
  var message;
  NotificationDilog({this.message});
  @override
  _NotificationDilogState createState() => _NotificationDilogState();
}

class _NotificationDilogState extends State<NotificationDilog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.message["notification"]["title"]}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.message["notification"]["body"]}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.grey[800]),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5, top: 15, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    color: appPrimaryMaterialColor,
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
