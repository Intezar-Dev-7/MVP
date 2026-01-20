import 'package:flutter/material.dart';

void showAnimatedSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    elevation: 1,
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}
