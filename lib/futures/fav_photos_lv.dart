import 'package:flutter/material.dart';
import 'package:imagify/bloc/db/db_bloc.dart';
import 'package:imagify/bloc/db/db_event.dart';
import 'package:imagify/bloc/db/db_state.dart';
import 'package:imagify/widgets/fav_screen_list_tile.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:imagify/widgets/custom_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagify/repositories/database_helper.dart';

class FavPhotosListView extends StatefulWidget {
  @override
  _FavPhotosListViewState createState() => _FavPhotosListViewState();
}

class _FavPhotosListViewState extends State<FavPhotosListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbBloc, DbState>(builder: (context, state) {
      if (state is FavPhotosLoaded) {
        return FavPhotosFuture(futurePhotosList: state.list);
      }
      if (state is FavPhotosError) {
        return Text('Error loading fav photos');
      }

      return Center(child: CircularProgressIndicator());
    });
  }
}

class FavPhotosFuture extends StatefulWidget {
  final Future futurePhotosList;
  FavPhotosFuture({this.futurePhotosList});
  @override
  _FavPhotosFutureState createState() => _FavPhotosFutureState();
}

class _FavPhotosFutureState extends State<FavPhotosFuture> {
  bool cpiVisibility = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _downloadPhoto(String url) async {
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
            builder: (BuildContext dialogContext) => CustomAlertBox(
                  message: 'Photo downloaded to $path',
                ));
      });
    } catch (e) {
      setState(() {
        cpiVisibility = false;
      });
      showDialog(
          context: _scaffoldKey.currentContext,
          builder: (BuildContext dialogContext) => CustomAlertBox(
                message: 'Photo couldn\'t be downloaded, sorry',
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _databaseHelper = RepositoryProvider.of<DatabaseHelper>(context);
    // ignore: close_sinks
    final _dbBloc = BlocProvider.of<DbBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
          future: widget.futurePhotosList,
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
                  ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return FSListTile(
                          favouritePhoto: snapshot.data[index],
                          onPressedDelete: () {
                            _dbBloc
                                .add(DeletePhoto(id: snapshot.data[index].id));
                          },
                          onPressedDownload: () async {
                            _downloadPhoto(snapshot.data[index].downloadUrl);
                          },
                        );
                      }),
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
