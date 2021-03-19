import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:imagify/model/photo.dart';
import 'package:imagify/widgets/custom_alert_box.dart';
import 'package:imagify/widgets/detailed_screen_icon_button.dart';
import 'package:imagify/widgets/detailed_screen_photo_text.dart';
import 'package:imagify/repositories/database_helper.dart';

class DetailedPhotoPage extends StatefulWidget {
  final Photo photo;
  DetailedPhotoPage({this.photo});
  @override
  _DetailedPhotoPageState createState() => _DetailedPhotoPageState();
}

class _DetailedPhotoPageState extends State<DetailedPhotoPage> {
  Color favColor = Colors.black;
  Color downloadColor = Colors.black;
  bool cpiVisibility = false;

  void _downloadPhoto() async {
    setState(() {
      cpiVisibility = true;
    });
    try {
      var img = await ImageDownloader.downloadImage(widget.photo.downloadUrl);
      await ImageDownloader.findPath(img).then((path) {
        setState(() {
          downloadColor = Colors.green;
          cpiVisibility = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) => CustomAlertBox(
                  message: 'Photo downloaded to $path',
                ));
      });
    } catch (e) {
      setState(() {
        cpiVisibility = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => CustomAlertBox(
                message: 'Photo couldn\'t be downloaded, sorry',
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF512DA8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 98.0),
          child: Text('Imagify'),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(alignment: AlignmentDirectional.center, children: [
                Image(
                  image: NetworkImage(widget.photo.photoUrlRegular),
                ),
                Visibility(
                  child: CircularProgressIndicator(),
                  visible: cpiVisibility,
                ),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DetailedScreenPhotoText(
                    textTitle: 'Description',
                    textDesc: widget.photo.photoAltDesc,
                  ),
                  DetailedScreenPhotoText(
                    textTitle: 'Author',
                    textDesc: widget.photo.photoAuthor,
                  ),
                  DetailedScreenPhotoText(
                    textTitle: 'Likes',
                    textDesc: widget.photo.likes.toString(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DetailedScreenIconButton(
                      iconData: Icons.favorite,
                      color: favColor,
                      onPressed: () async {
                        DatabaseHelper db = DatabaseHelper();
                        FavouritePhoto favPhoto = FavouritePhoto();
                        favPhoto.desc = widget.photo.photoAltDesc;
                        favPhoto.url = widget.photo.photoUrlRegular;
                        favPhoto.author = widget.photo.photoAuthor;
                        favPhoto.likes = widget.photo.likes;
                        favPhoto.downloadUrl = widget.photo.downloadUrl;
                        await db.insertFavPhoto(favPhoto);
                        setState(() {
                          favColor = Colors.red;
                        });
                      },
                    ),
                    DetailedScreenIconButton(
                      iconData: Icons.file_download,
                      color: downloadColor,
                      onPressed: () {
                        _downloadPhoto();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
