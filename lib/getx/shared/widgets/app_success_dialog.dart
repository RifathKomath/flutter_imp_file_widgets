import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/core/extensions/margin_extension.dart';
import 'package:valet_parking_app/core/style/colors.dart';

import '../../core/style/fonts.dart';
import 'app_lottie.dart';
class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    super.key,
    required this.message,
    this.onComplete,
    this.duration = const Duration(milliseconds: 2000),
  });

  final String message;
  final VoidCallback? onComplete;
  final Duration duration;

  static void show({
    required String message,
    VoidCallback? onComplete,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    Get.dialog(
      SuccessDialog(
        message: message,
        onComplete: onComplete,
        duration: duration,
      ),
      barrierDismissible: false,
    );

    Future.delayed(duration, () {
      if (Get.isDialogOpen ?? false) {
        Get.back();
        onComplete?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLottie(assetName: "success",height: 94,width: 94,),
           
            Text(
              message,
              style: AppTextStyles.textStyle_500_14.copyWith(
                fontSize: 16,
                color: blackTextClr,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
