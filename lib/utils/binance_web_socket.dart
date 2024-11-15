import 'package:web_socket_channel/io.dart';

class BinanceWebSocket {
  final String symbol;
  final String interval;
  late IOWebSocketChannel channel;

  BinanceWebSocket(this.symbol, this.interval) {
    channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}@kline_$interval',
    );
  }

  Stream get stream => channel.stream;

  void close() {
    channel.sink.close();
  }
}
