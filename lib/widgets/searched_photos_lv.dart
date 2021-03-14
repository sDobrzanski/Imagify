import 'package:flutter/material.dart';
import 'package:imagify/images_data.dart';
import 'package:imagify/widgets/home_screen_list_tile.dart';
import 'package:imagify/screens/detailed_photo_page.dart';

class SearchedPhotosLV extends StatefulWidget {
  final String keyword;
  SearchedPhotosLV({this.keyword});
  @override
  _SearchedPhotosLVState createState() => _SearchedPhotosLVState();
}

class _SearchedPhotosLVState extends State<SearchedPhotosLV> {
  final ImagesData _imagesData = ImagesData();

  ListView _searchedPhotosListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return HSListTile(
            title: data['results'][index]['description'] == null
                ? 'Title'
                : data['results'][index]['description'],
            url: data['results'][index]['urls']['small'],
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailedPhotoPage(),
                  ));
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imagesData.searchImage(widget.keyword),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else if (snapshot.hasData) {
          return _searchedPhotosListView(snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
