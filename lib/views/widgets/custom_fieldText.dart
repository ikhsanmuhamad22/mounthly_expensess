import 'package:flutter/material.dart';

class CustomFieldtext extends StatelessWidget {
  const CustomFieldtext({
    super.key,
    required this.title,
    required this.controller,
  });

  final String title;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(fontSize: 16),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1.5),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
