import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool hidetext;

  AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hidetext = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        TextField(controller: controller, obscureText: hidetext),
        SizedBox(height: 16),
      ],
    );
  }
}
