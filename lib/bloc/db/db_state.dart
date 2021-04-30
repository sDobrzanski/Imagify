import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:imagify/repositories/database_helper.dart';

abstract class DbState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavPhotosLoading extends DbState {}

class FavPhotosLoaded extends DbState {
  final Future<List<FavouritePhoto>> list;
  FavPhotosLoaded({@required this.list});
  @override
  List<Object> get props => [list];
}

class FavPhotosError extends DbState {
  final String error;

  FavPhotosError({@required this.error});

  @override
  List<Object> get props => [error];
}
