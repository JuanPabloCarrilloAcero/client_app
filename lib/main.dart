import 'package:client_app/screens/unvest_app.dart';
import 'package:client_app/services/authentication_service.dart';
import 'package:client_app/services/graphql_service.dart';
import 'package:client_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp(
      {Key? key})
      : super(key: key);

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
