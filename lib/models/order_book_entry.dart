class OrderBookEntry {
  final String price;
  final String amount;

  OrderBookEntry({required this.price, required this.amount});

  double get total => double.parse(price) * double.parse(amount);
}
