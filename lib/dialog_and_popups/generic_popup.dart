import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_button.dart';

Future<void> showSimplePopup(BuildContext context,
    {String? title,
    bool showTitle = true,
    bool barrierDismissible = false,
    String content = "",
    Widget? customIcon,
    Widget? contentBody,
    double? contentBottomPadding,
    TextAlign? textAlign,
    String? okText,
    String? cancelText,
    Function()? onOkPressed,
    Function()? onCancelPressed,
    Color? footerColor}) async {
  return showDialog<void>(
    barrierColor: CustomColors.blackColor.withOpacity(0.75),
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, _) {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: CustomColors.blackBgColor(ref)),
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding:
                const EdgeInsets.only(top: 35, bottom: 25, left: 15, right: 10),
            content: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customIcon ??
                        SvgPicture.asset(
                          ConstantString.iconErrorOutline,
                          height: 50,
                        ),
                    verticalSpacer(15),
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Network Restriction',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: CustomColors.redBgColor),
                        ),
                      ),
                    ),
                    verticalSpacer(15),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: contentBody ??
                            Text(
                              content,
                              textAlign: textAlign ?? TextAlign.center,
                              style: const TextStyle(
                                  height: 1.4,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                      ),
                    ),
                    verticalSpacer(contentBottomPadding ?? 40),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: CustomButton(
                                    height: 38,
                                    buttonColor: CustomColors.redBgColor,
                                    title: "Okay",
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpacer(10),
                        ],
                      ),
                    ),
                    verticalSpacer(10),
                  ],
                ),
              ),
            ),
          ),
        );
      });
    },
  );
}
