import 'package:client_app/widgets/deposit_retire.dart';
import 'package:client_app/screens/unvest_app.dart';
import 'package:client_app/widgets/watchlist.dart';
import 'package:client_app/services/authentication_service.dart';
import 'package:client_app/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {

  AuthenticationService authService = AuthenticationService();


  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthenticationService authService;


  const MyApp({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'UNvest';

    return MaterialApp(
      title: title,
      home: UNvestApp(authService: authService),
      theme: unvestTheme,
    );
  }
}

