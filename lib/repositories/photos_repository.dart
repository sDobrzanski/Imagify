import 'package:flutter/material.dart';
import 'package:imagify/repositories/unsplash_api_client.dart';
import 'package:imagify/model/photo.dart';

class PhotosRepository {
  final UnsplashApiClient unsplashApiClient;

  PhotosRepository({@required this.unsplashApiClient})
      : assert(unsplashApiClient != null);

  Future<List<Photo>> fetchRandomPhotos() async {
    return await unsplashApiClient.getRandomData();
  }

  Future<List<Photo>> fetchSearchedPhotos(String keyword) async {
    return await unsplashApiClient.getSearchedData(keyword);
  }
}
