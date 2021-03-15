import 'package:flutter/material.dart';

class DetailedScreenIconButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  final Color color;
  DetailedScreenIconButton({this.iconData, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IconButton(
          icon: Icon(iconData),
          iconSize: 40,
          color: color,
          onPressed: onPressed),
    );
  }
}
