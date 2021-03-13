import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function onChanged;
  final Function onPressed;
  final TextEditingController controller;
  CustomTextField({this.controller, this.onChanged, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Look for a photo',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onPressed,
            color: Color(0xFF7C4DFF),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF673AB7), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF673AB7), width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
