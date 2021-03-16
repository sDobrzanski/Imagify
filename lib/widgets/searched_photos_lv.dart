import 'package:flutter/material.dart';
import 'package:imagify/repositories/unsplash_api_client.dart';
import 'package:imagify/repositories/photos_repository.dart';
import 'package:imagify/screens/detailed_photo_page.dart';

import 'home_screen_list_tile.dart';

class SearchedPhotosLV extends StatefulWidget {
  final String keyword;
  SearchedPhotosLV({this.keyword});
  @override
  _SearchedPhotosLVState createState() => _SearchedPhotosLVState();
}

class _SearchedPhotosLVState extends State<SearchedPhotosLV> {
  final PhotosRepository _repo =
      PhotosRepository(unsplashApiClient: UnsplashApiClient());

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
      future: _repo.fetchSearchedPhotos(widget.keyword),
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
