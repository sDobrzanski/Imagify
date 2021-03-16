import 'package:flutter/material.dart';
import 'package:imagify/repositories/photos_repository.dart';
import 'package:imagify/repositories/unsplash_api_client.dart';
import 'package:imagify/screens/detailed_photo_page.dart';
import 'package:imagify/widgets/home_screen_list_tile.dart';

class RandomPhotosListView extends StatefulWidget {
  @override
  _RandomPhotosListViewState createState() => _RandomPhotosListViewState();
}

class _RandomPhotosListViewState extends State<RandomPhotosListView> {
  final PhotosRepository _repo =
      PhotosRepository(unsplashApiClient: UnsplashApiClient());
  Future _data;

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
    _data = _repo.fetchRandomPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
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
