import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final EdgeInsetsGeometry contentPadding;
  final TextEditingController controller;
  final BorderRadiusGeometry borderRadius;
  final Icon? prefixIcon; // Add this property for the prefix icon

  const CustomTextInput({
    Key? key,
    this.hintText = 'Enter your text here',
    this.hintStyle = const TextStyle(color: Colors.grey, fontSize: 16),
    this.contentPadding = const EdgeInsets.all(10.0),
    required this.controller,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.prefixIcon, // Default border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: borderRadius, // Border radius
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          contentPadding: contentPadding,
          border: InputBorder.none, // No border
          prefixIcon: prefixIcon, // Set the prefix icon here
        ),
      ),
    );
  }
}
