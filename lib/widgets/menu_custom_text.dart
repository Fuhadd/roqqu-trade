import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

class MenuText extends StatelessWidget {
  final String title;
  final WidgetRef ref;
  final bool isSelected;
  const MenuText({
    super.key,
    required this.title,
    required this.ref,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 35,
          width: 150,
          decoration: BoxDecoration(
              color: isSelected
                  ? CustomColors.menuTextColor(ref)
                  : Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: semiBoldText(
              title,
              fontSize: 16,
              color: CustomColors.whiteTextColor(ref),
            ),
          ),
        ),
      ),
    );
  }
}
