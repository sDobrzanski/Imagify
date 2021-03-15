import 'package:flutter/material.dart';

class DetailedScreenPhotoText extends StatelessWidget {
  final String textTitle;
  final String textDesc;
  DetailedScreenPhotoText({this.textTitle, this.textDesc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: new TextSpan(
          style: new TextStyle(
            fontSize: 17.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: '$textTitle: ',
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new TextSpan(text: textDesc),
          ],
        ),
      ),
    );
  }
}
