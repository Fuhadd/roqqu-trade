import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/data/repositories/local_cache/local_cache.dart';
import 'package:roqqu_trade/locator.dart';
import 'package:roqqu_trade/models/chart_data.dart';
import 'package:roqqu_trade/models/currency_pair_model.dart';
import 'package:roqqu_trade/utils/enum.dart';

final userThemeProvider =
    StateProvider<AppTheme>((ref) => locator<LocalCache>().getUserTheme());

final selectedCurrencyPairProvider =
    StateProvider.autoDispose<CurrencyPair>((ref) => getCurrencyPairs[0]);

final chartDataProvider =
    StateProvider.autoDispose<List<ChartData>>((ref) => []);

final selectedTimeFrame =
    StateProvider.autoDispose<TimeFrame>((ref) => TimeFrame.oneMonth);

final currentPriceProvider = StateProvider.autoDispose<double?>((ref) => null);
final priceColorProvider =
    StateProvider.autoDispose<Color>((ref) => CustomColors.whiteColor);
