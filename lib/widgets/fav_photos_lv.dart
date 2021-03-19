import 'package:flutter/material.dart';
import 'package:imagify/repositories/database_helper.dart';
import 'package:imagify/widgets/fav_screen_list_tile.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:imagify/widgets/custom_alert_box.dart';

class FavPhotosListView extends StatefulWidget {
  @override
  _FavPhotosListViewState createState() => _FavPhotosListViewState();
}

class _FavPhotosListViewState extends State<FavPhotosListView> {
  final DatabaseHelper db = DatabaseHelper();
  bool cpiVisibility = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  download(String url) async {
    setState(() {
      cpiVisibility = true;
    });
    try {
      var img = await ImageDownloader.downloadImage(url);
      await ImageDownloader.findPath(img).then((path) {
        setState(() {
          cpiVisibility = false;
        });
        showDialog(
            context: _scaffoldKey.currentContext,
            builder: (BuildContext dialogContex) => CustomAlertBox(
                  message: 'Photo downloaded to $path',
                ));
      });
    } catch (e) {
      setState(() {
        cpiVisibility = false;
      });
      showDialog(
          context: _scaffoldKey.currentContext,
          builder: (BuildContext dialogContex) => CustomAlertBox(
                message: 'Photo couldn\'t be downloaded, sorry',
              ));
    }
  }

  ListView favPhotosListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return FSListTile(
            favouritePhoto: data[index],
            onPressedDelete: () async {
              await db.delete(data[index].id);
              setState(() {});
            },
            onPressedDownload: () async {
              download(data[index].downloadUrl);
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
          future: db.returnFavPhotos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  favPhotosListView(snapshot.data),
                  Visibility(
                      visible: cpiVisibility,
                      child: CircularProgressIndicator()),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
