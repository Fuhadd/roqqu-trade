import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String? routeName;
  final Color? textColor;
  final bool isLoading;
  final bool isBoldTitle;
  final bool borderButton;
  final double? width, height;
  final void Function()? onTap;
  final Color? buttonColor;
  final double? fontSize;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.title,
    this.routeName,
    this.onTap,
    this.isLoading = false,
    this.isBoldTitle = true,
    this.borderButton = false,
    this.width,
    this.height,
    this.buttonColor,
    this.textColor = CustomColors.whiteColor,
    this.fontSize,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap ?? () {},
      child: Container(
        height: height ?? 45,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: onTap == null || isLoading
              ? buttonColor == null
                  ? CustomColors.greenButtonColor.withOpacity(0.6)
                  : buttonColor!.withOpacity(0.5)
              : buttonColor ?? CustomColors.greenButtonColor,
          border: isOutlined
              ? Border.all(color: CustomColors.greenButtonColor)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            semiBoldText(
              title,
              fontSize: fontSize ?? 16,
              color: textColor,
            ),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SpinKitFadingCircle(
                        color: textColor ?? CustomColors.whiteColor,
                        size: 25.0,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        )),
      ),
    );
  }
}
