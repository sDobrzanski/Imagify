import 'package:flutter/material.dart';
import 'package:imagify/widgets/detailed_screen_icon_button.dart';
import 'package:imagify/widgets/detailed_screen_photo_text.dart';

//TODO to refactor
class FSListTile extends StatelessWidget {
  final String url;
  final String desc;
  final String author;
  final int likes;
  final Function onPressed;
  FSListTile({this.desc, this.likes, this.author, this.url, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(url),
            ),
            DetailedScreenPhotoText(
              textTitle: 'Description',
              textDesc: desc,
            ),
            DetailedScreenPhotoText(
              textTitle: 'Author',
              textDesc: author,
            ),
            DetailedScreenPhotoText(
              textTitle: 'Likes',
              textDesc: likes.toString(),
            ),
            DetailedScreenIconButton(
              iconData: Icons.clear,
              color: Colors.black,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
