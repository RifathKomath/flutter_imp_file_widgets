import 'package:flutter/cupertino.dart';
extension NumberExtension on num {
  Widget get hBox => SizedBox(height: toDouble());
  Widget get wBox => SizedBox(width: toDouble());
}

extension PaddingExtension on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);
  Widget paddingSymmetricHorizontal(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);
  Widget paddingSymmetricVertical(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);
}


