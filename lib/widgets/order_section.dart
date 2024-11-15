import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/widgets/expandable_container.dart';

class OrdersSection extends StatelessWidget {
  const OrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
          decoration: BoxDecoration(
            color: CustomColors.expandedBgColor(ref),
            border: Border(
              top: BorderSide(
                  width: 10, color: CustomColors.blackBorderColor(ref)),
              right: BorderSide(
                  width: 1, color: CustomColors.blackBorderColor(ref)),
              left: BorderSide(
                  width: 1, color: CustomColors.blackBorderColor(ref)),
              bottom: BorderSide(
                  width: 3, color: CustomColors.blackBorderColor(ref)),
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: const OrdersExpandableContainer());
    });
  }
}
