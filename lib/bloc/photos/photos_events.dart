import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class PhotosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRandomPhotos extends PhotosEvent {}

class LoadSearchedPhotos extends PhotosEvent {
  final String searchKey;

  LoadSearchedPhotos({@required this.searchKey});

  @override
  List<Object> get props => [searchKey];
}
