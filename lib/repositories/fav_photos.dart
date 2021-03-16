import 'package:flutter/cupertino.dart';

//TODO to refactor
class FavPhotos {
  List<Widget> _favPhotos = [];

  void addFavPhoto(Widget photoToAdd) {
    _favPhotos.add(photoToAdd);
  }

  void deleteFavPhoto(int index) {
    _favPhotos.removeAt(index);
  }

  List<Widget> getFavPhotos() {
    return _favPhotos;
  }
}
