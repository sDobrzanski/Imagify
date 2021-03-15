import 'package:http/http.dart' as http;
import 'dart:convert';
import 'key.dart';

const unsplashUrl = 'https://api.unsplash.com';

class ImagesData {
  http.Response _response;
  Key _key = Key();

  Future<void> searchImage(String keyword) async {
    _response = await http.get(Uri.parse(
        '$unsplashUrl/search/photos/?client_id=${_key.accessKey}&page=1&per_page=10&query=$keyword'));
    if (_response.statusCode == 200) {
      var decodedData = jsonDecode(_response.body);
      return decodedData;
    } else {
      print(_response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future<dynamic> getRandomImages() async {
    _response = await http.get(Uri.parse(
        '$unsplashUrl/photos/random/?client_id=${_key.accessKey}&count=30'));
    if (_response.statusCode == 200) {
      var decodedData = jsonDecode(_response.body);
      return decodedData;
    } else {
      print(_response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
