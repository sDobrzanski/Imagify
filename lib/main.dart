import 'package:flutter/material.dart';
import 'images_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ImagesData imagesData = ImagesData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: TextButton(
              onPressed: () async {
                await imagesData.getRandomImage();
              },
              child: Text('Get data'),
            ),
          ),
        ),
      ),
    );
  }
}
