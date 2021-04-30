import 'package:flutter/material.dart';
import 'package:imagify/screens/detailed_photo_page.dart';
import 'package:imagify/model/photo.dart';
import '../widgets/home_screen_list_tile.dart';

class SearchedPhotosLV extends StatefulWidget {
  final Future<List<Photo>> photoList;
  SearchedPhotosLV({this.photoList});
  @override
  _SearchedPhotosLVState createState() => _SearchedPhotosLVState();
}

class _SearchedPhotosLVState extends State<SearchedPhotosLV> {
  ListView _searchedPhotosListView(data) {
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget
          .photoList, //widget.photoList_repo.fetchSearchedPhotos(widget.keyword)
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
