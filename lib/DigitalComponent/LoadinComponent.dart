import 'package:flutter/material.dart';

class LoadinComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.4),
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white)),
      ),
    );
  }
}
