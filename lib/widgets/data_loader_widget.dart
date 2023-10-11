import 'package:flutter/material.dart';

class DataLoaderWidget<T> extends StatelessWidget {
  final Future<T> Function() fetchData;
  final Widget Function(T data) builder;

  const DataLoaderWidget({super.key, required this.fetchData, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still loading, show a circular progress indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Handle errors if necessary
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Data has been loaded, call the builder function to display the content
          return builder(snapshot.data as T);
        }
      },
    );
  }
}
