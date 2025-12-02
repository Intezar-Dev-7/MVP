import 'package:flutter/material.dart';

void showAnimatedSnackBar(BuildContext context, String message) {
  final controller = AnimationController(
    vsync: Navigator.of(context),
    duration: const Duration(milliseconds: 450),
  );

  final curvedAnim = CurvedAnimation(
    parent: controller,
    curve: Curves.easeOutBack,
  );

  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    ),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: const Duration(milliseconds: 2000),
    animation: curvedAnim,
  );

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);

  controller.forward();
}
