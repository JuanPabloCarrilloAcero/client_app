import 'package:client_app/models/dashboard_model.dart';
import 'package:client_app/widgets/data_card_widget.dart';
import 'package:flutter/material.dart';

class DashboardPredictionsWidget extends StatelessWidget {
  const DashboardPredictionsWidget({super.key, required this.predictions});

  final List<Prediction> predictions;

  @override
  Widget build(BuildContext context) {
    return DataCardWidget(
        title: 'Predictions',
        data: predictions
            .map((prediction) =>
                '${prediction.ticker}, ${prediction.value.toStringAsFixed(2)} %')
            .toList());
  }
}
