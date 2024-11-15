import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/dialog_and_popups/generic_popup.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/models/chart_data.dart';
import 'package:roqqu_trade/utils/binance_web_socket.dart';
import 'package:roqqu_trade/utils/custom_text_styles.dart';
import 'package:roqqu_trade/utils/enum.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_time_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class TradingScreen extends StatefulHookConsumerWidget {
  const TradingScreen({super.key});

  @override
  ConsumerState<TradingScreen> createState() => TradingScreenState();
}

class TradingScreenState extends ConsumerState<TradingScreen> {
  List<ChartData> _chartData = [];
  late BinanceWebSocket _webSocket;
  bool _loading = true;
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;
  double? currentPrice;
  double? previousClosePrice;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchInitialData();
      _startWebSocket();
    });
  }

  Future<void> _fetchInitialData() async {
    setState(() {
      _loading = true;
    });
    _chartData = await fetchHistoricalData(
        'BTCUSDT', getTimeFrameText(ref.watch(selectedTimeFrame)), context);
    setState(() {
      _loading = false;
    });
  }

  void _startWebSocket() {
    _webSocket = BinanceWebSocket(
        'BTCUSDT', getTimeFrameText(ref.watch(selectedTimeFrame)));
    _webSocket.stream.listen((message) {
      final data = jsonDecode(message);
      final kline = data['k'];
      final newPoint = ChartData(
        date: DateTime.fromMillisecondsSinceEpoch(kline['t']),
        open: double.parse(kline['o']),
        high: double.parse(kline['h']),
        low: double.parse(kline['l']),
        close: double.parse(kline['c']),
        volume: double.parse(kline['v']),
      );

      setState(() {
        previousClosePrice = _chartData.last.close;

        currentPrice = double.parse(kline['c']);
        ref.read(currentPriceProvider.notifier).state =
            double.parse(kline['c']);

        if (previousClosePrice != null) {
          ref.read(priceColorProvider.notifier).state =
              currentPrice! > previousClosePrice!
                  ? CustomColors.greenTextColor
                  : currentPrice! < previousClosePrice!
                      ? CustomColors.redTextColor
                      : CustomColors.whiteColor;
        }

        if (kline['x']) {
          _chartData.add(newPoint);
        } else {
          if (_chartData.isNotEmpty) {
            _chartData[_chartData.length - 1] = newPoint;
          } else {
            _chartData.add(newPoint);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _webSocket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              TimeText(
                title: 'Time',
                onTap: () {},
              ),
              TimeText(
                title: '1M',
                onTap: () {
                  //ToDO: abstract this functions and make it geeric
                  ref.read(selectedTimeFrame.notifier).state =
                      TimeFrame.oneMonth;
                  _fetchInitialData();
                  _startWebSocket();
                },
              ),
              TimeText(
                title: '1H',
                onTap: () {
                  ref.read(selectedTimeFrame.notifier).state =
                      TimeFrame.oneHour;
                  _fetchInitialData();
                  _startWebSocket();
                },
              ),
              TimeText(
                title: '2H',
                onTap: () {
                  ref.read(selectedTimeFrame.notifier).state =
                      TimeFrame.twoHours;
                  _fetchInitialData();
                  _startWebSocket();
                },
              ),
              TimeText(
                title: '4H',
                onTap: () {
                  ref.read(selectedTimeFrame.notifier).state =
                      TimeFrame.threeHours;
                  _fetchInitialData();
                  _startWebSocket();
                },
              ),
              TimeText(
                title: '1D',
                onTap: () {
                  ref.read(selectedTimeFrame.notifier).state = TimeFrame.oneDay;
                  _fetchInitialData();
                  _startWebSocket();
                },
              ),
              TimeText(
                title: '1W',
                onTap: () {
                  ref.read(selectedTimeFrame.notifier).state =
                      TimeFrame.oneWeek;
                  _fetchInitialData();
                  _startWebSocket();
                },
              ),
            ],
          ),
        ),
        _loading
            ? Expanded(child: Center(child: loader()))
            : Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 30,
                      child: Image.asset(
                        ConstantString.columnChart,
                        width: 300,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SfCartesianChart(
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                      plotAreaBorderWidth: 0,
                      backgroundColor: Colors.transparent,
                      zoomPanBehavior: _zoomPanBehavior,
                      trackballBehavior: _trackballBehavior,
                      primaryXAxis: DateTimeAxis(
                        intervalType: DateTimeIntervalType.minutes,
                        //TODO: change the date format depending on the time Format being fetchd
                        dateFormat: DateFormat('MM/yy'),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        majorGridLines: const MajorGridLines(width: 0),
                        labelStyle: CustomTextStyles.w500(
                            color: CustomColors.lighterWhiteTextColor(ref),
                            fontSize: 9),
                      ),
                      primaryYAxis: NumericAxis(
                        opposedPosition: true,
                        majorGridLines: const MajorGridLines(width: 0),
                        desiredIntervals: 4,
                        labelStyle: CustomTextStyles.w500(
                            color: CustomColors.lighterWhiteTextColor(ref),
                            fontSize: 9),
                        plotBands: <PlotBand>[
                          if (currentPrice != null)
                            PlotBand(
                              isVisible: true,
                              start: currentPrice,
                              end: currentPrice,
                              borderColor: Colors.green,
                              borderWidth: 1,
                              dashArray: const [6, 3],
                            ),
                        ],
                        axisLabelFormatter: (AxisLabelRenderDetails details) {
                          if (currentPrice != null &&
                              details.value == currentPrice) {
                            return ChartAxisLabel(
                              '\$${details.value.toStringAsFixed(2)}',
                              CustomTextStyles.semiBold(
                                  color: CustomColors.greenTextColor,
                                  fontSize: 9),
                            );
                          } else {
                            return ChartAxisLabel(
                              '\$${details.value.toStringAsFixed(2)}',
                              CustomTextStyles.w500(
                                  color:
                                      CustomColors.lighterWhiteTextColor(ref),
                                  fontSize: 9),
                            );
                          }
                        },
                      ),
                      annotations: <CartesianChartAnnotation>[
                        CartesianChartAnnotation(
                          widget: Image.asset(
                            ConstantString.whiteCompanyLogo,
                            width: 100,
                            height: 30,
                          ),
                          coordinateUnit: CoordinateUnit.logicalPixel,
                          x: 0,
                          y: MediaQuery.of(context).size.height * 0.85,
                        ),
                      ],
                      series: <CartesianSeries>[
                        CandleSeries<ChartData, DateTime>(
                          dataSource: _chartData,
                          xValueMapper: (ChartData data, _) => data.date,
                          lowValueMapper: (ChartData data, _) => data.low,
                          highValueMapper: (ChartData data, _) => data.high,
                          openValueMapper: (ChartData data, _) => data.open,
                          closeValueMapper: (ChartData data, _) => data.close,
                          name: 'BTC/USDT',
                          bearColor: Colors.red,
                          bullColor: Colors.green,
                          animationDuration: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

Future<List<ChartData>> fetchHistoricalData(
    String symbol, String interval, BuildContext context) async {
  try {
    final url = Uri.parse(
        'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval&limit=50');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) {
        return ChartData(
          date: DateTime.fromMillisecondsSinceEpoch(e[0]),
          open: double.parse(e[1]),
          high: double.parse(e[2]),
          low: double.parse(e[3]),
          close: double.parse(e[4]),
          volume: double.parse(e[5]),
        );
      }).toList();
    } else {
      showSimplePopup(context,
          textAlign: TextAlign.left,
          content:
              'Binance APIs are not accessible from Nigeria or US locations.\n\n Please download and use a VPN to access this feature.');
      throw Exception('Failed to load historical data');
    }
  } catch (e) {
    showSimplePopup(context,
        textAlign: TextAlign.left,
        content:
            'Binance APIs are not accessible from Nigeria or US locations.\n\n Please download and use a VPN to access this feature.');
    throw Exception(e.toString());
  }
}
