import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';

Widget horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

Widget verticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget loader(
    {double size = 35, Color? color = CustomColors.gradientPurpleColor}) {
  return SpinKitRipple(
    color: color,
    size: size,
  );
}
