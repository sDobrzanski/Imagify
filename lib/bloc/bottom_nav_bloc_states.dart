import 'package:flutter/material.dart';
import 'package:imagify/model/photo.dart';

@immutable
abstract class BottomNavigationState {
  BottomNavigationState();
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});
}

class PageLoading extends BottomNavigationState {}

class FirstPageLoadedWithRandom extends BottomNavigationState {
  final Future<List<Photo>> photosListRandom;

  FirstPageLoadedWithRandom({@required this.photosListRandom});
}

class SecondPageLoaded extends BottomNavigationState {
  SecondPageLoaded();
}
