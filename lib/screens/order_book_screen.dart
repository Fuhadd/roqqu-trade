import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/models/order_book_entry.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';
import 'package:roqqu_trade/widgets/order_list.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';

class OrderBookScreen extends StatefulWidget {
  const OrderBookScreen({super.key});

  @override
  State<OrderBookScreen> createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen> {
  final String symbol = 'btcusdt';
  String symbolIcon = ConstantString.dashIcon;
  final int depthLevel = 20;
  late IOWebSocketChannel channel;
  late IOWebSocketChannel tickerChannel;
  List<OrderBookEntry> asks = [];
  List<OrderBookEntry> bids = [];
  double? midPrice;
  double? previousMidPrice;
  Color midPriceColor = Colors.white;
  bool isLoading = true;
  bool isRetry = false;

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  //Todo: Create a seperate service for all websockets
  void connectToWebSocket() {
    channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/$symbol@depth$depthLevel',
    );

    channel.stream.listen((message) {
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
      }
      print("Received data: $message");
      final data = jsonDecode(message);

      setState(() {
        if (data['asks'] != null && data['bids'] != null) {
          asks = (data['asks'] as List)
              .take(10)
              .map((item) => OrderBookEntry(price: item[0], amount: item[1]))
              .toList();
          bids = (data['bids'] as List)
              .take(10)
              .map((item) => OrderBookEntry(price: item[0], amount: item[1]))
              .toList();

          if (asks.isNotEmpty && bids.isNotEmpty) {
            double highestBid = double.parse(bids.first.price);
            double lowestAsk = double.parse(asks.first.price);
            previousMidPrice = midPrice;
            midPrice = (highestBid + lowestAsk) / 2;

            if (previousMidPrice != null) {
              if (midPrice! > previousMidPrice!) {
                midPriceColor = CustomColors.greenButtonColor;
                symbolIcon = ConstantString.highIcon;
              } else if (midPrice! < previousMidPrice!) {
                midPriceColor = CustomColors.redTextColor;
                symbolIcon = ConstantString.lowIcon;
              } else {
                midPriceColor = Colors.white;
                symbolIcon = ConstantString.dashIcon;
              }
            }
          }
        } else {
          log("Warning: 'asks' or 'bids' data is missing");
        }
      });
    }, onError: (error) {
      log("WebSocket error: $error");
    }, onDone: () {
      log("WebSocket connection closed");
    });
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(
              child: loader(),
            )
          : isRetry
              ? Center(
                  child: w500Text(
                      "Could not complete request, Please turn on vpn, and try again",
                      textAlign: TextAlign.center,
                      color: CustomColors.greyTextColor),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(child: OrderList(orders: asks, isAsk: true)),
                      verticalSpacer(10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            w500Text(
                              midPrice != null
                                  ? midPrice!.toStringAsFixed(2)
                                  : '------:--',
                              color: midPriceColor,
                              fontSize: 16,
                            ),
                            horizontalSpacer(15),
                            SvgPicture.asset(
                              midPriceColor == CustomColors.redTextColor
                                  ? ConstantString.lowIcon
                                  : ConstantString.highIcon,
                              color: midPriceColor,
                            ),
                            horizontalSpacer(15),
                            w500Text(
                              midPrice != null
                                  ? midPrice!.toStringAsFixed(2)
                                  : '------:--',
                              color: CustomColors.whiteColor,
                              fontSize: 16,
                            )
                          ],
                        ),
                      ),
                      verticalSpacer(10),
                      Expanded(child: OrderList(orders: bids, isAsk: false)),
                    ],
                  ),
                ),
    );
  }
}
