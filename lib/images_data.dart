import 'package:http/http.dart' as http;
import 'dart:convert';
import 'key.dart';

const unsplashUrl = 'https://api.unsplash.com';

class ImagesData {
  http.Response _response;
  Key _key = Key();

  Future<void> getRandomImage() async {
    _response = await http.get(
        Uri.parse('$unsplashUrl/photos/random/?client_id=${_key.accessKey}'));
    if (_response.statusCode == 200) {
      var decodedData = jsonDecode(_response.body);
      print(decodedData);
    } else {
      print(_response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
