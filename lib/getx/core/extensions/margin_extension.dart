import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumberExtension on num {
  /// <b>SizedBox(height: 8)<b/>
  Widget get hBox => SizedBox(height: toDouble().h);

  /// <b>SizedBox(width: 8)<b/>
  Widget get wBox => SizedBox(width: toDouble().w);
}

extension PaddingExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);
  Widget paddingOnly(double top, double bottom, double left, double right) =>
      Padding(
        padding: EdgeInsets.only(
          top: top.h,
          bottom: bottom.h,
          left: left.w,
          right: right.w,
        ),
        child: this,
      );
  Widget paddingVertHor(double horizontal, double vertical) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h),
    child: this,
  );
}
