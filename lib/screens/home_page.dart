import 'package:flutter/material.dart';
import 'package:imagify/widgets/custom_text_field.dart';
import 'package:imagify/images_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImagesData imagesData = ImagesData();
  String keyword;
  final keywordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              CustomTextField(
                controller: keywordController,
                onChanged: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
                onPressed: () async {
                  //await imagesData.searchImage(keyword);
                  await imagesData.getRandomImages();
                  FocusScope.of(context).requestFocus(FocusNode());
                  keywordController.clear();
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        iconSize: 30,
        selectedItemColor: Color(0xFF512DA8),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
      ),
    );
  }
}
