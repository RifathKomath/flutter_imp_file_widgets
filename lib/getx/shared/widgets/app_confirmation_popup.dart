import 'package:flutter/material.dart';
import 'package:valet_parking_app/core/extensions/margin_extension.dart';
import 'package:valet_parking_app/core/style/colors.dart';
import 'package:valet_parking_app/shared/widgets/app_btn.dart';
import '../../core/style/fonts.dart';
import '../utils/screen_util.dart';

Future<bool?> appShowDialog(
  BuildContext context, {
  required String dialog,

  Function()? onTap,
}) {
  bool isProcessing = false;

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        content: Text(
          dialog,
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyle_500_14.copyWith(fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(bottom: 16),
        actions: [
          AppButton(
            text: "No",
            isExpand: false,
            btnClr: primaryClr,
            minHeight: 40,
            onPressed: () {
              Screen.close();
            },
          ),
          20.wBox,
          AppButton(
            text: "Yes",
            isExpand: false,
            minHeight: 40,
            btnClr: primaryClr,
            onPressed: () {
              Screen.close();
              if (!isProcessing) {
                isProcessing = true;
                onTap?.call();
              }
            },
          ),
        ],
      );
    },
  );
}
