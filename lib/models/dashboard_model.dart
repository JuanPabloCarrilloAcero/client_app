class DashboardModel {
  late List<Prediction> predictions;

  DashboardModel({required this.predictions});
}

class Prediction {
  final String ticker;
  final double value;

  Prediction({
    required this.ticker,
    required this.value,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      ticker: json['ticker'],
      value: (json['value'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Prediction{ticker: $ticker, value: $value}';
  }
}
