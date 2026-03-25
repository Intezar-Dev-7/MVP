// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EditProfileCustomtexfield extends StatelessWidget {
  final TextEditingController controller;
  final bool required;
  int maxLines;
  final int? maxLength;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  EditProfileCustomtexfield({
    super.key,

    required this.controller,
    required this.required,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.helperText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          validator: validator,

          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white38),
            helperText: helperText,
            helperStyle: const TextStyle(color: Colors.white38, fontSize: 12),
            filled: true,
            fillColor: const Color(0xFF1A1A1A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            counterStyle: const TextStyle(color: Colors.white38),
          ),
        ),
      ],
    );
  }
}
