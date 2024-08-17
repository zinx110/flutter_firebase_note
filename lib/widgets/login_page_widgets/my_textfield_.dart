import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  InputBorder border({Color color = Colors.black}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color));

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: border(),
        focusedBorder: border(color: Colors.blueAccent.shade200),
        errorBorder: border(color: Colors.red),
      ),
    );
  }
}
