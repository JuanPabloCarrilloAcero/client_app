import 'package:client_app/models/dashboard_model.dart';
import 'package:flutter/material.dart';

class DashboardPredictionsWidget extends StatelessWidget {
  const DashboardPredictionsWidget({super.key, required this.predictions});

  final List<Prediction> predictions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      // Add shadow to the card for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16), // Add padding for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Predictions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Add vertical spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Align items at the start
              children: predictions.map((prediction) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Adjust the padding as needed
                  child: Text(
                    '${prediction.ticker}, ${prediction.value.toStringAsFixed(2)} %',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
