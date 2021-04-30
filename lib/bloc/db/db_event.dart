import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:imagify/repositories/database_helper.dart';

abstract class DbEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFavPhotos extends DbEvent {}

class AddPhoto extends DbEvent {
  final FavouritePhoto photo;
  AddPhoto({this.photo});
  @override
  List<Object> get props => [photo];
}

class DeletePhoto extends DbEvent {
  final int id;
  DeletePhoto({this.id});
  @override
  List<Object> get props => [id];
}

class DeleteAllPhotos extends DbEvent {}
