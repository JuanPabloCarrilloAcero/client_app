import 'package:client_app/methods/formatCurrency.dart';
import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardBalanceWidget extends StatelessWidget {
  const DashboardBalanceWidget({super.key, required this.amount});
  final double amount;

  @override
  Widget build(BuildContext context) {

    return DataCardWidget(title: "Balance", data: [formatCurrency(amount)]);
  }
}