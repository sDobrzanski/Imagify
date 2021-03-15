import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:imagify/widgets/custom_alert_box.dart';
import 'package:imagify/widgets/detailed_screen_icon_button.dart';
import 'package:imagify/widgets/detailed_screen_photo_text.dart';

class DetailedPhotoPage extends StatefulWidget {
  final String fullUrl;
  final String desc;
  final String username;
  final int views;
  final String downloadUrl;
  DetailedPhotoPage(
      {this.fullUrl, this.username, this.desc, this.views, this.downloadUrl});
  @override
  _DetailedPhotoPageState createState() => _DetailedPhotoPageState();
}

class _DetailedPhotoPageState extends State<DetailedPhotoPage> {
  Color favColor = Colors.black;
  Color downloadColor = Colors.black;

  void _downloadPhoto() async {
    try {
      var img = await ImageDownloader.downloadImage(widget.downloadUrl);
      await ImageDownloader.findPath(img).then((path) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CustomAlertBox(
                  message: 'Photo downloaded to $path',
                ));
      });
    } catch (e) {
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
              Expanded(
                child: Image(
                  image: NetworkImage(widget.fullUrl),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DetailedScreenPhotoText(
                    textTitle: 'Description',
                    textDesc: widget.desc,
                  ),
                  DetailedScreenPhotoText(
                    textTitle: 'User',
                    textDesc: widget.username,
                  ),
                  DetailedScreenPhotoText(
                    textTitle: 'Views',
                    textDesc: widget.views.toString(),
                  )
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
                      onPressed: () {
                        setState(() {
                          favColor = Colors.red;
                        });
                      },
                    ),
                    DetailedScreenIconButton(
                      iconData: Icons.file_download,
                      color: downloadColor,
                      onPressed: () {
                        setState(() {
                          downloadColor = Colors.green;
                        });
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
