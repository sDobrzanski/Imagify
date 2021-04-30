import 'package:flutter/material.dart';

@immutable
abstract class BottomNavigationState {
  BottomNavigationState();
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});
}

class PageLoading extends BottomNavigationState {}

class FirstPageLoadedWithRandom extends BottomNavigationState {}

class SecondPageLoaded extends BottomNavigationState {}
