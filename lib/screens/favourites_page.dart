import 'package:flutter/material.dart';
import 'package:imagify/futures/fav_photos_lv.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(children: [
          Expanded(
            child: FavPhotosListView(),
          ),
        ])),
      ),
    );
  }
}
