import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  bool isPassword;
  String hinttxt;
  TextEditingController controller;
  MyTextfield({
    super.key,
    required this.isPassword,
    required this.hinttxt,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hinttxt,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }
}
