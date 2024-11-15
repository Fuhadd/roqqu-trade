import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/models/order_book_entry.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

class OrderList extends StatelessWidget {
  final List<OrderBookEntry> orders;
  final bool isAsk;

  const OrderList({super.key, required this.orders, required this.isAsk});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final color =
            isAsk ? CustomColors.redTextColor : CustomColors.greenButtonColor;
        return Consumer(builder: (context, ref, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    height: 20,
                    width: order.total / 1000,
                    color: color.withOpacity(0.3),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: w500Text(
                          double.parse(order.price).toStringAsFixed(2),
                          color: color,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: w500Text(
                          double.parse(order.amount).toStringAsFixed(6),
                          color: CustomColors.whiteTextColor(ref),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: w500Text(
                          order.total.toStringAsFixed(2),
                          color: CustomColors.whiteTextColor(ref),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
