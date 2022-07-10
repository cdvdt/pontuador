import 'package:flutter/material.dart';

class CustomDialog {
  static Future<bool?> question(BuildContext context,
      {String? title, required String message, required void Function(bool value) handler}) {
    return showDialog<bool>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
                handler(true);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
                handler(false);
              },
            ),
          ],
        );
      },
    );
  }
}
