import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardBalanceWidget extends StatelessWidget {
  const DashboardBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return const DataCardWidget(title: "Balance", data: ["We are working on this feature!"]);
  }
}