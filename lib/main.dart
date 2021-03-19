import 'package:flutter/material.dart';
import 'package:imagify/bloc/bottom_nav_bloc_events.dart';
import 'file:///C:/Users/szdob/AndroidStudioProjects/imagify/lib/screens/custom_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagify/bloc/bottom_nav_bloc.dart';
import 'package:imagify/repositories/photos_repository.dart';
import 'package:imagify/repositories/unsplash_api_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(accentColor: Color(0xFF7C4DFF)),
      home: BlocProvider<BottomNavigationBloc>(
          create: (context) => BottomNavigationBloc(
              photosRepository:
                  PhotosRepository(unsplashApiClient: UnsplashApiClient()))
            ..add(AppStarted()),
          child: CustomBottomBar()),
    );
  }
}
