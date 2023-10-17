import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../models/discover_model.dart';

class DiscoverValuableWidget extends StatelessWidget {
  const DiscoverValuableWidget({super.key, required this.valuableStocks});

  final List<ValuableStock> valuableStocks;

  @override
  Widget build(BuildContext context) {
    return DataCardWidget(
        title: 'Performance last 30 days',
        data: valuableStocks
            .map((valuableStock) =>
        '${valuableStock.ticker}, ${valuableStock.value.toStringAsFixed(2)} %')
            .toList());
  }
}