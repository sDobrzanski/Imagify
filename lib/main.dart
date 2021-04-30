import 'package:flutter/material.dart';
import 'package:imagify/bloc/bottom_nav_bar/bottom_nav_bloc.dart';
import 'package:imagify/bloc/bottom_nav_bar/bottom_nav_bloc_events.dart';
import 'screens/custom_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagify/bloc/db/db_bloc.dart';
import 'package:imagify/bloc/db/db_event.dart';
import 'package:imagify/bloc/photos/photos_bloc.dart';
import 'package:imagify/bloc/photos/photos_events.dart';
import 'package:imagify/repositories/database_helper.dart';
import 'package:imagify/repositories/photos_repository.dart';
import 'package:imagify/repositories/unsplash_api_client.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => UnsplashApiClient()),
      RepositoryProvider(
          create: (context) =>
              PhotosRepository(unsplashApiClient: UnsplashApiClient())),
      RepositoryProvider(create: (context) => DatabaseHelper()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavigationBloc>(create: (context) {
          final photosRepository =
              RepositoryProvider.of<PhotosRepository>(context);
          return BottomNavigationBloc(photosRepository: photosRepository)
            ..add(AppStarted());
        }),
        BlocProvider<PhotosBloc>(create: (context) {
          final photosRepository =
              RepositoryProvider.of<PhotosRepository>(context);
          return PhotosBloc(photosRepository)..add(LoadRandomPhotos());
        }),
        BlocProvider<DbBloc>(create: (context) {
          final databaseHelper = RepositoryProvider.of<DatabaseHelper>(context);
          return DbBloc(databaseHelper)..add(LoadFavPhotos());
        }),
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(accentColor: Color(0xFF7C4DFF)),
      home: CustomBottomBar(),
    );
  }
}
