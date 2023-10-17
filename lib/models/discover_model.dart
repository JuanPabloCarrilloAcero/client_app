class DiscoverModel {
  late List<ValuableStock> valuableStocks;
  late List<Company> companies;

  DiscoverModel({required this.valuableStocks, required this.companies});
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

class Company {
  final String id;
  final String ticker;
  final String name;
  final String description;
  final String sector;
  final String industry;
  final String address;

  Company({
    required this.id,
    required this.ticker,
    required this.name,
    required this.description,
    required this.sector,
    required this.industry,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'],
      ticker: json['ticker'],
      name: json['nombre'],
      description: json['descripcion'],
      sector: json['sector'],
      industry: json['industria'],
      address: json['direccion'],
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, ticker: $ticker, name: $name, description: $description, sector: $sector, industry: $industry, address: $address}';
  }

}
