import 'package:roqqu_trade/constants/custom_string.dart';

class CurrencyPair {
  final String pair;
  final String pairPlainText;
  final String pairImage;

  CurrencyPair(
    this.pair,
    this.pairPlainText,
    this.pairImage,
  );
}

List<CurrencyPair> getCurrencyPairs = [
  CurrencyPair(
    'BTC/USDT',
    'BTCUSDT',
    ConstantString.btcImage,
  ),
  CurrencyPair(
    'ETH/USDT',
    'ETHUSDT',
    ConstantString.ethImage,
  ),
  CurrencyPair(
    'LTC/USDT',
    'LTCUSDT',
    ConstantString.ltcImage,
  ),
  CurrencyPair(
    'BNB/USDT',
    'BNBUSDT',
    ConstantString.bnbImage,
  ),
  CurrencyPair(
    'SOL/USDT',
    'SOLUSDT',
    ConstantString.solImage,
  ),
];
