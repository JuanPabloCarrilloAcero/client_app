class DiscoverModel {
  late List<ValuableStock> valuableStocks;

  DiscoverModel({required this.valuableStocks});
}

class ValuableStock {
  final String ticker;
  final double value;

  ValuableStock({
    required this.ticker,
    required this.value,
  });

  factory ValuableStock.fromJson(Map<String, dynamic> json) {
    return ValuableStock(
      ticker: json['ticker'],
      value: (json['value'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Prediction{ticker: $ticker, value: $value}';
  }
}
