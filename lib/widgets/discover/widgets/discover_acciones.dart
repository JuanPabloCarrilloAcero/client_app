import 'package:flutter/material.dart';

import '../../../methods/generateRandomStockPrice.dart';
import '../../../models/discover_model.dart';
import '../../data_card_stock_modal_widget.dart';

class DiscoverAccionesWidget extends StatelessWidget {
  const DiscoverAccionesWidget({super.key, required this.companies});

  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return DataCardStockModalWidget(
        data: companies
            .map((company) => StockDTO(
                ticker: company.ticker,
                name: company.name,
                description: company.description,
                id: company.id,
                price: generateRandomStockPrice().toString()))
            .toList());
  }
}
