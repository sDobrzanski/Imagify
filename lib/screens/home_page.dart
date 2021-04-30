import 'package:flutter/material.dart';
import 'package:imagify/bloc/photos/photos_events.dart';
import 'package:imagify/repositories/photos_repository.dart';
import 'package:imagify/widgets/custom_text_field.dart';
import 'package:imagify/widgets/random_photos_lv.dart';
import 'package:imagify/widgets/searched_photos_lv.dart';
import 'package:imagify/model/photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagify/bloc/photos/photos_bloc.dart';
import 'package:imagify/bloc/photos/photos_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String keyword;
  bool isSearching = false;
  var randomImages;
  final keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<PhotosBloc, PhotosState>(
        builder: (context, state) {
          if (state is RandomPhotosLoaded) {
            return PhotosList(photoList: state.list);
          }

          if (state is SearchedPhotosLoaded) {
            return PhotosList(photoList: state.list);
          }

          if (state is RandomPhotosError) {
            return Text('${state.error}');
          }

          if (state is SearchedPhotosError) {
            return Text('${state.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

class PhotosList extends StatefulWidget {
  final Future<List<Photo>> photoList;
  PhotosList({this.photoList});
  @override
  _PhotosListState createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> {
  bool isSearched = false;
  final keywordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _photosRepository = RepositoryProvider.of<PhotosRepository>(context);
    // ignore: close_sinks
    final _photosBloc = BlocProvider.of<PhotosBloc>(context);
    return Container(
        child: BlocProvider<PhotosBloc>(
      create: (context) => PhotosBloc(_photosRepository),
      child: Column(
        children: <Widget>[
          CustomTextField(
            controller: keywordController,
            onChanged: (value) {
              setState(() {
                if (value.isNotEmpty) {
                  isSearched = true;
                  _photosBloc.add(LoadSearchedPhotos(searchKey: value));
                } else {
                  isSearched = false;
                  _photosBloc.add(LoadRandomPhotos());
                }
              });
              // FocusScope.of(context).requestFocus(FocusNode());
              // keywordController.clear();
            },
          ),
          Divider(height: 1, thickness: 1, color: Color(0xFF673AB7)),
          Expanded(
            child: !isSearched
                ? RandomPhotosListView(photoList: widget.photoList)
                : SearchedPhotosLV(
                    photoList: widget.photoList,
                  ),
          ),
        ],
      ),
    ));
  }
}
