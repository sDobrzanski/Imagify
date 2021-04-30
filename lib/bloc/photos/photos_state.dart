import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:imagify/model/photo.dart';

abstract class PhotosState extends Equatable {
  @override
  List<Object> get props => [];
}

class RandomPhotosLoading extends PhotosState {}

class SearchedPhotosLoading extends PhotosState {}

class RandomPhotosLoaded extends PhotosState {
  final Future<List<Photo>> list;
  RandomPhotosLoaded({@required this.list});
  @override
  List<Object> get props => [list];
}

class SearchedPhotosLoaded extends PhotosState {
  final Future<List<Photo>> list;
  SearchedPhotosLoaded({@required this.list});
  @override
  List<Object> get props => [list];
}

class RandomPhotosError extends PhotosState {
  final String error;

  RandomPhotosError({@required this.error});

  @override
  List<Object> get props => [error];
}

class SearchedPhotosError extends PhotosState {
  final String error;

  SearchedPhotosError({@required this.error});

  @override
  List<Object> get props => [error];
}
