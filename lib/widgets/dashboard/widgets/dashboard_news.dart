import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardNewsWidget extends StatelessWidget {
  const DashboardNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return const DataCardWidget(title: "News", data: ["data"]);
  }
}