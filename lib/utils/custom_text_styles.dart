import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle semiBold(
          {double? fontSize = 13, Color? color, double? height}) =>
      TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: color,
        height: height,
      );

  static TextStyle regular(
          {double? fontSize = 13, Color? color, double? height}) =>
      TextStyle(
        fontFamily: "Satoshi",
        fontSize: fontSize,
        color: color,
        height: height,
      );

  static TextStyle w500(
          {double? fontSize = 13, Color? color, double? height}) =>
      TextStyle(
        fontFamily: "Satoshi",
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        color: color,
        height: height,
      );
}
