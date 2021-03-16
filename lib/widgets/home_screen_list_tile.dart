import 'package:flutter/material.dart';
import 'package:imagify/model/photo.dart';

class HSListTile extends StatelessWidget {
  final Function onTap;
  final Photo photo;
  HSListTile({this.photo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 25),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: <Widget>[
              Image(
                image: NetworkImage(photo.photoUrlSmall),
              ),
              Text(
                photo.photoDesc,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
