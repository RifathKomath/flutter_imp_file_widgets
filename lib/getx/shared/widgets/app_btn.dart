import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/style/colors.dart';
import '../../core/style/fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.btnRadius = 12,
      this.icon,
      this.isExpand = true,
      this.isRounded = true,
      this.isFilledBtn = true,
      this.isLoaderBtn = false,
      this.minHeight,
      this.borderSideClr,
      this.btnClr = primaryClr,
      this.elevation,
      this.bgclr,
      this.textstyle,
      this.isLightBaground = false});

  final void Function()? onPressed;
  final String text;
  final Color btnClr;
  final Color? borderSideClr,bgclr;
  final Widget? icon;
  final bool isExpand, isRounded, isFilledBtn, isLoaderBtn;
  final double? minHeight;
  final double btnRadius;
  final double? elevation;
  final bool isLightBaground;
final  TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpand ? double.infinity : null,
      height: minHeight?.h,
      child: icon == null
          ? TextButton(
              onPressed: isLoaderBtn ? null : onPressed,
              style: _buildStyle(),
              child: ButtonText(
                text: text,
                style: textstyle,
                btnClr: btnClr,
                isLoaderBtn: isLoaderBtn,
                isFilledBtn: isFilledBtn,
                isLightBaground: isLightBaground,
              ),
            )
          : TextButton.icon(
              onPressed: isLoaderBtn ? null : onPressed,
              style: _buildStyle(),
              icon: icon!,
              label: ButtonText(
                text: text,
                btnClr: btnClr,
                isLoaderBtn: isLoaderBtn,
                isFilledBtn: isFilledBtn,
                isLightBaground: isLightBaground,
              ),
            ),
    );
  }

  ButtonStyle _buildStyle() {
    return TextButton.styleFrom(
        elevation: elevation ?? (isFilledBtn ? 0 : 0),
        shadowColor: isFilledBtn ? btnClr : null,
        iconColor: Colors.white,
      
        padding: minHeight == null
            ? EdgeInsets.symmetric(horizontal: 16.w, vertical: isExpand ? 14.h : 14.h)
            : null,
        backgroundColor: isFilledBtn ? btnClr :bgclr?? Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderSideClr ?? btnClr),
            borderRadius:
                BorderRadius.all(Radius.circular(isRounded ? btnRadius.r : 0))));
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText(
      {super.key,
      required this.text,
      required this.btnClr,
      required this.isFilledBtn,
      this.style,
      this.isLightBaground = false,
      this.isLoaderBtn = false,
      this.textClr = whiteClr});

  final String text;
  final Color btnClr;
  final bool isFilledBtn, isLoaderBtn;
  final bool isLightBaground;
  final Color textClr;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return isLoaderBtn
        ? const CupertinoActivityIndicator(
            color: Colors.black,
            animating: true,
          )
        : Text(text,
        style:style?? AppTextStyles.textStyle_600_14.copyWith( color: isFilledBtn && isLightBaground
                ? textClr
                : isFilledBtn
                    ? Colors.white
                    : btnClr),
          
           );
  }
}