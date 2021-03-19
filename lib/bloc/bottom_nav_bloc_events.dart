import 'package:flutter/material.dart';

abstract class BottomNavigationEvent {
  const BottomNavigationEvent();
}

class AppStarted extends BottomNavigationEvent {}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index});
}
