import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  final String message;
  CustomAlertBox({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Ok',
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
