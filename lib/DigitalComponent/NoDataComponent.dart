import 'package:flutter/material.dart';

class NoDataComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.6),
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10),
        child: Text("No Data Available",
            style: TextStyle(
                fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
