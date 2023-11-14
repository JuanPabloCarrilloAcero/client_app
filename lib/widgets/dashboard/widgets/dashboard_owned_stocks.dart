import 'package:client_app/models/dashboard_model.dart';
import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardOwnedStocks extends StatelessWidget {
  const DashboardOwnedStocks({super.key, required this.stocks});
  final List<Owned> stocks;

  @override
  Widget build(BuildContext context) {
    List<String> stringList = stocks.map((owned) => "${owned.ticker} - ${owned.value}").toList();

    return DataCardWidget(title: "Owned Stocks", data: stringList);
  }
}