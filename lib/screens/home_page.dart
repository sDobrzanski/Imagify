import 'package:flutter/material.dart';
import 'package:imagify/widgets/custom_text_field.dart';
import 'package:imagify/widgets/random_photos_lv.dart';
import 'package:imagify/images_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImagesData _imagesData = ImagesData();
  String keyword;
  var randomImages;
  final keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
                  await _imagesData.searchImage(keyword);
                  FocusScope.of(context).requestFocus(FocusNode());
                  keywordController.clear();
                },
              ),
              Divider(height: 1, thickness: 1, color: Color(0xFF673AB7)),
              Expanded(
                child: RandomPhotosListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
