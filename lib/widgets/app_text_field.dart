import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final bool obscureText;
  final FocusNode? focusNode;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.obscureText = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
      ),
    );
  }
}
