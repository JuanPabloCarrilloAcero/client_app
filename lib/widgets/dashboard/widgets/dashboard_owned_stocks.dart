import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardOwnedStocks extends StatelessWidget {
  const DashboardOwnedStocks({super.key});

  @override
  Widget build(BuildContext context) {

    return const DataCardWidget(title: "Owned Stocks", data: ["data"]);
  }
}