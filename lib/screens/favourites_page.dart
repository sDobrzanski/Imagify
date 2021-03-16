import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  final List<Widget> favPhotosList;
  FavouritesPage({this.favPhotosList});
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  List<Widget> myList = [];
  @override
  void initState() {
    super.initState();
    myList = widget.favPhotosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return myList[index];
            }),
      ),
    );
  }
}
