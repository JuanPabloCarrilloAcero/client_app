import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../models/discover_model.dart';

class DiscoverAccionesWidget extends StatelessWidget {
  const DiscoverAccionesWidget({super.key, required this.valuableStocks});

  final List<ValuableStock> valuableStocks;

  @override
  Widget build(BuildContext context) {
    return DataCardWidget(
        title: 'Acciones',
        data: valuableStocks
            .map((valuableStock) =>
                '${valuableStock.ticker}, ${valuableStock.value.toStringAsFixed(2)} %')
            .toList());
  }
}