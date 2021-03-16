import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/key.dart';
import 'package:imagify/model/photo.dart';

const unsplashUrl = 'https://api.unsplash.com';

class UnsplashApiClient {
  http.Response _response;
  Key _key = Key();

  Future<List<Photo>> getRandomData() async {
    List<Photo> randomPhotos;
    _response = await http.get(Uri.parse(
        '$unsplashUrl/photos/random/?client_id=${_key.accessKey}&count=30'));
    if (_response.statusCode == 200) {
      return randomPhotos = (json.decode(_response.body) as List).map((i) {
        return Photo.fromJson(i);
      }).toList();
    } else {
      print(_response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future<List<Photo>> getSearchedData(String keyword) async {
    List<Photo> randomPhotos;
    _response = await http.get(Uri.parse(
        '$unsplashUrl/search/photos/?client_id=${_key.accessKey}&page=1&per_page=10&query=$keyword'));
    if (_response.statusCode == 200) {
      return randomPhotos =
          (json.decode(_response.body)['results'] as List).map((i) {
        return Photo.fromJson(i);
      }).toList();
    } else {
      print(_response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
