import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/screens/order_book_screen.dart';
import 'package:roqqu_trade/screens/trading_screen.dart';
import 'package:roqqu_trade/utils/custom_text_styles.dart';
import 'package:roqqu_trade/utils/spacers.dart';

class ChartSection extends StatefulHookConsumerWidget {
  const ChartSection({super.key});

  @override
  ConsumerState<ChartSection> createState() => ChartSectionState();
}

class ChartSectionState extends ConsumerState<ChartSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<TradingScreenState> chartKey =
      GlobalKey<TradingScreenState>();

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpacer(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: CustomColors.blackBorderColor(ref),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: CustomColors.blackBorderColor(ref),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: CustomColors.whiteTextColor(ref),
                      unselectedLabelColor:
                          CustomColors.lighterWhiteTextColor(ref),
                      labelStyle: CustomTextStyles.semiBold(
                        fontSize: 14,
                        color: CustomColors.whiteTextColor(ref),
                      ),
                      unselectedLabelStyle: CustomTextStyles.w500(
                        fontSize: 14,
                        color: CustomColors.whiteTextColor(ref),
                      ),
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColors.selectedTabColor(ref),
                      ),
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: 'Charts',
                        ),
                        Tab(
                          text: 'Orderbook',
                        ),
                        Tab(
                          text: 'Recent trades',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(16),
              // height: 300,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  TradingScreen(),
                  OrderBookScreen(),
                  OrderBookScreen(),
                ],
              )),
        ),
      ],
    );
  }
}
