import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/utils/enum.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

class TimeText extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const TimeText({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 22.0),
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: getTimeFrameText(ref.watch(selectedTimeFrame)) ==
                      title.toLowerCase()
                  ? CustomColors.timeFrameBgColor(ref)
                  : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: w500Text(
                  title,
                  color: CustomColors.whiteTextColor(ref),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
