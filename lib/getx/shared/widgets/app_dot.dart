import 'package:flutter/material.dart';

class AppDot extends StatelessWidget {
  const AppDot({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
  width: 8,
  height: 8,
  decoration: BoxDecoration(
    color:color, // your custom color
    shape: BoxShape.circle,
  ),
);
  }
}