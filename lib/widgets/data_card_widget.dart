import 'package:flutter/material.dart';

class DataCardWidget extends StatelessWidget {
  const DataCardWidget({super.key, required this.title, required this.data});

  final String title;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Add vertical spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align items at the start
                children: data.map((value) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    // Adjust the padding as needed
                    child: Text(
                      value,
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
      ),
    );
  }
}
