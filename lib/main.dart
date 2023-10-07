import 'package:client_app/screens/unvest_app.dart';
import 'package:client_app/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    const title = 'UNvest';

    return MaterialApp(
      title: title,
      home: const UNvestApp(),
      theme: unvestTheme,
    );
  }
}
