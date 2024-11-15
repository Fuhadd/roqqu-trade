import 'package:flutter/material.dart';
import 'package:roqqu_trade/widgets/chart_section.dart';
import 'package:roqqu_trade/widgets/order_section.dart';
import 'package:roqqu_trade/widgets/trade_info_section.dart';

class TradeScreenBody extends StatelessWidget {
  const TradeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const TradeInfoSection(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const ChartSection(),
          ),
          const OrdersSection(),
        ],
      ),
    );
  }
}
