import 'package:flutter/material.dart';
import 'package:imagify/screens/detailed_photo_page.dart';
import 'package:imagify/widgets/home_screen_list_tile.dart';
import 'package:imagify/model/photo.dart';

class RandomPhotosListView extends StatefulWidget {
  final Future<List<Photo>> photoList;
  RandomPhotosListView({this.photoList});
  @override
  _RandomPhotosListViewState createState() => _RandomPhotosListViewState();
}

class _RandomPhotosListViewState extends State<RandomPhotosListView> {
  ListView _randomPhotosListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return HSListTile(
            photo: data[index],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedPhotoPage(
                      photo: data[index],
                    ),
                  ));
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
    return FutureBuilder(
      future: widget.photoList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Text("error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          return _randomPhotosListView(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
