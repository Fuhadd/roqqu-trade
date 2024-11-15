import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/utils/custom_text_styles.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

import '../constants/custom_colors.dart';

Widget customTextField(String label, WidgetRef ref,
    {String? hintText,
    String? labelText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? prefix,
    String? initialValue,
    bool isCurrency = false,
    bool isNumber = false,
    bool isHint = false,
    bool obscureText = false,
    bool readOnly = false,
    String? helperText,
    String? Function(String?)? validator,
    TextEditingController? controller,
    void Function()? onSuffixTap,
    void Function(String?)? onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 55,
        child: TextField(
          cursorColor: CustomColors.blackColor.withOpacity(0.5),
          obscureText: obscureText,
          readOnly: readOnly,
          onChanged: onChanged,
          controller: controller,
          style: CustomTextStyles.regular(
              fontSize: 14, color: CustomColors.blackColor),
          keyboardType: isNumber ? TextInputType.phone : null,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: CustomColors.dividerGreyColor(ref), width: 0.8),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CustomColors.dividerGreyColor(ref),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: w500Text(
                    '0.00 USD',
                    color: CustomColors.greyTextColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            prefixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    horizontalSpacer(10),
                    w500Text(
                      label,
                      color: CustomColors.greyTextColor,
                      fontSize: 15,
                    ),
                    horizontalSpacer(5),
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.info_outline_rounded,
                        color: CustomColors.greyTextColor,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ],
            ),
            filled: false,
            hintText: hintText,
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            floatingLabelStyle: CustomTextStyles.regular(
                fontSize: 12, color: CustomColors.gradientPurpleColor),
            labelStyle: CustomTextStyles.regular(
                fontSize: 14, color: CustomColors.greyTextColor),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: CustomTextStyles.regular(
                fontSize: 14, color: CustomColors.greyTextColor),
          ),
        ),
      ),
    ],
  );
}
