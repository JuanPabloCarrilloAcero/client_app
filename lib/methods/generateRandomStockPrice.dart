import 'dart:math';

double generateRandomStockPrice({double minPrice = 10.0, double maxPrice = 200.0}) {
  final random = Random();
  final range = maxPrice - minPrice;
  final randomPrice = minPrice + random.nextDouble() * range;
  return double.parse(randomPrice.toStringAsFixed(2));
}