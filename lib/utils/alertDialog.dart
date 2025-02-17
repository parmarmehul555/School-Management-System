import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/utils/theme.dart';

class ShowAlertDialog {
  void showDialog(context, String alertTitle, String alertContent) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(alertTitle),
          content: Text(alertContent),
          actions: [
            CupertinoButton(
              child: Text("Ok",style: TextStyle(color: ColorTheme().PRIMARY_COLOR),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
