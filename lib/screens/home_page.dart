import 'package:flutter/material.dart';
import 'package:imagify/widgets/custom_text_field.dart';
import 'package:imagify/widgets/random_photos_lv.dart';
import 'package:imagify/widgets/searched_photos_lv.dart';

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
  void initState() {
    super.initState();
    isSearching = false;
  }

  @override
  void dispose() {
    isSearching = false;
    super.dispose();
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
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                  keywordController.clear();
                },
              ),
              Divider(height: 1, thickness: 1, color: Color(0xFF673AB7)),
              Expanded(
                child: !isSearching || keyword.isEmpty
                    ? RandomPhotosListView()
                    : SearchedPhotosLV(
                        keyword: keyword,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
