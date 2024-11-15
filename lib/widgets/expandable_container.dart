import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/utils/custom_text_styles.dart';

class OrdersExpandableContainer extends StatefulHookConsumerWidget {
  final bool isExpanded;
  const OrdersExpandableContainer({
    super.key,
    this.isExpanded = false,
  });

  @override
  ConsumerState<OrdersExpandableContainer> createState() =>
      _OrdersExpandableContainerState();
}

class _OrdersExpandableContainerState
    extends ConsumerState<OrdersExpandableContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: CustomColors.tabBlackColor(ref),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: CustomColors.blackBorderColor(ref),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: CustomColors.whiteTextColor(ref),
                    unselectedLabelColor:
                        CustomColors.lighterWhiteTextColor(ref),
                    labelStyle: CustomTextStyles.semiBold(
                      fontSize: 14,
                      color: CustomColors.whiteColor,
                    ),
                    unselectedLabelStyle: CustomTextStyles.w500(
                      fontSize: 14,
                      color: CustomColors.whiteColor,
                    ),
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.secondExpandedBgColor(ref),
                    ),
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Open Orders',
                      ),
                      Tab(
                        text: 'Positions',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No Open Orders",
                          style: TextStyle(
                              color: CustomColors.whiteTextColor(ref),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: CustomColors.greyTextColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No Open Orders",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
