import 'package:flutter/material.dart';
import 'package:imagify/repositories/database_helper.dart';
import 'package:imagify/widgets/detailed_screen_icon_button.dart';
import 'package:imagify/widgets/detailed_screen_photo_text.dart';

class FSListTile extends StatelessWidget {
  final FavouritePhoto favouritePhoto;
  final Function onPressedDelete;
  final Function onPressedDownload;
  FSListTile(
      {this.favouritePhoto, this.onPressedDelete, this.onPressedDownload});

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
              image: NetworkImage(favouritePhoto.url),
            ),
            DetailedScreenPhotoText(
              textTitle: 'Description',
              textDesc: favouritePhoto.desc,
            ),
            DetailedScreenPhotoText(
              textTitle: 'Author',
              textDesc: favouritePhoto.author,
            ),
            DetailedScreenPhotoText(
              textTitle: 'Likes',
              textDesc: favouritePhoto.likes.toString(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DetailedScreenIconButton(
                  iconData: Icons.clear,
                  color: Colors.black,
                  onPressed: onPressedDelete,
                ),
                DetailedScreenIconButton(
                  iconData: Icons.file_download,
                  color: Colors.black,
                  onPressed: onPressedDownload,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
