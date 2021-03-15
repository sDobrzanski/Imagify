import 'package:flutter/material.dart';
import 'package:imagify/images_data.dart';
import 'package:imagify/screens/detailed_photo_page.dart';
import 'package:imagify/widgets/home_screen_list_tile.dart';

class RandomPhotosListView extends StatefulWidget {
  @override
  _RandomPhotosListViewState createState() => _RandomPhotosListViewState();
}

class _RandomPhotosListViewState extends State<RandomPhotosListView> {
  final ImagesData _imagesData = ImagesData();
  Future _data;

  ListView _randomPhotosListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return HSListTile(
            title: data[index]['description'] == null
                ? 'Title'
                : data[index]['description'],
            url: data[index]['urls']['small'],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedPhotoPage(
                        fullUrl: data[index]['urls']['regular'],
                        username: data[index]['user']['username'],
                        desc: data[index]['description'] == null
                            ? data[index]['alt_description']
                            : data[index]['description'],
                        views: data[index]['views'],
                        downloadUrl: data[index]['links']['download']),
                  ));
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _data = _imagesData.getRandomImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.hasData) {
          return _randomPhotosListView(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
