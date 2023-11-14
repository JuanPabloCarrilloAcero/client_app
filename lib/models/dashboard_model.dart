class DashboardModel {
  late List<Prediction> predictions;
  late List<News> news;
  late double balance;
  late List<Owned> owned;

  DashboardModel({required this.predictions, required this.news, required this.balance, required this.owned});
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

class News {
  final String titulo;
  final String url;

  News({
    required this.titulo,
    required this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      titulo: json['titulo'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'News{titulo: $titulo, url: $url}';
  }
}

class Owned {
  final String ticker;
  final double value;

  Owned({
    required this.ticker,
    required this.value,
  });

  factory Owned.fromJson(Map<String, dynamic> json) {
    return Owned(
      ticker: json['ticker'],
      value: (json['cantidad'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Owned{ticker: $ticker, value: $value}';
  }
}
