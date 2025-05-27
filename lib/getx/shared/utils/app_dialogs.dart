import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> showCustomDialog<T>({
    required Widget content,
    bool barrierDismissible = false,
    double radius = 16.0,
    EdgeInsets? padding,
    Color backgroundColor = Colors.white,
  }) {
    return Get.dialog<T>(
      Dialog(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Container(
          width: Get.width * 0.9,
          padding: padding ?? EdgeInsets.all(20),
          child: content,
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }