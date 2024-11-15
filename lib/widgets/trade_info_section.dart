import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/models/currency_pair_model.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_dropdown.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';
import 'package:roqqu_trade/widgets/extra_details_container.dart';

class TradeInfoSection extends StatelessWidget {
  const TradeInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 10, color: CustomColors.blackBorderColor(ref)),
            right:
                BorderSide(width: 1, color: CustomColors.blackBorderColor(ref)),
            left:
                BorderSide(width: 1, color: CustomColors.blackBorderColor(ref)),
            top:
                BorderSide(width: 3, color: CustomColors.blackBorderColor(ref)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CustomListDropdownField(
                        items: getCurrencyPairs,
                        selectedItem: selectedCurrencyPairProvider,
                      ),
                    ],
                  ),
                  horizontalSpacer(20),
                  w500Text(
                    "\$${ref.watch(currentPriceProvider) == null ? '----:--' : ref.watch(currentPriceProvider)?.toStringAsFixed(2)}",
                    fontSize: 19,
                    color: ref.watch(priceColorProvider),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExtraDetailsContainer(
                        title: "24h change",
                        subtitle: "520.80  +1.25%",
                        icon: ConstantString.timeIcon,
                        subtitleColor: CustomColors.greenTextColor,
                      ),
                      ExtraDetailsContainer(
                        title: "24h high",
                        subtitle: "520.80  +1.25%",
                        icon: ConstantString.highIcon,
                      ),
                      ExtraDetailsContainer(
                        title: "24h low",
                        subtitle: "520.80  +1.25%",
                        icon: ConstantString.lowIcon,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
