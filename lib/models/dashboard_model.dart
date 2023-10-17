class DashboardModel {
  late List<Prediction> predictions;
  late List<News> news;

  DashboardModel({required this.predictions, required this.news});
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
