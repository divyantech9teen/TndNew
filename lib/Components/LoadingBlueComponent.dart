import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

class LoadingBlueComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
      ),
    );
  }
}
