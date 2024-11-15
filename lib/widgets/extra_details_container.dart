import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

class ExtraDetailsContainer extends StatelessWidget {
  final String title, subtitle, icon;
  final Color? subtitleColor;
  const ExtraDetailsContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                  ),
                  horizontalSpacer(5),
                  w500Text(
                    title,
                    color: CustomColors.greyTextColor,
                    fontSize: 13,
                  ),
                ],
              ),
              verticalSpacer(5),
              w500Text(
                subtitle,
                color: subtitleColor ??
                    CustomColors.whiteTextColor(
                      ref,
                    ),
                fontSize: 15,
              ),
            ],
          ),
          horizontalSpacer(20),
          Container(
            height: 48,
            width: 1,
            decoration: BoxDecoration(
              color: CustomColors.dividerColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          horizontalSpacer(15),
        ],
      );
    });
  }
}
