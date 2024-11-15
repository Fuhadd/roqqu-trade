import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/dialog_and_popups/bottomsheets/generic_bottom_sheet.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_button.dart';
import 'package:roqqu_trade/widgets/purchase_form.dart';

class TradeScreenBottomBar extends StatelessWidget {
  const TradeScreenBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        color: CustomColors.buttonBgColor(ref),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CustomButton(
                  title: "Buy",
                  onTap: () async {
                    showGenericBottomSheet(
                      context,
                      ref,
                      title: "",
                      child: const PurchaseForm(),
                    );
                  },
                ),
              ),
              horizontalSpacer(20),
              Expanded(
                child: CustomButton(
                  title: "Sell",
                  buttonColor: CustomColors.redButtonColor,
                  onTap: () async {},
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
