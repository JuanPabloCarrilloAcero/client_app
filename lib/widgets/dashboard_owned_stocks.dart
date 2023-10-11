import 'package:flutter/material.dart';

class DashboardOwnedStocks extends StatelessWidget {
  const DashboardOwnedStocks({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 10, // Add shadow to the card for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      child: const Padding(
        padding: EdgeInsets.all(16), // Add padding for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your stocks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Add vertical spacing
            Text(
              'Text', // Use your noticias data
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}