import 'package:client_app/services/authentication_service.dart';
import 'package:client_app/widgets/home/home.dart';
import 'package:flutter/material.dart';

import '../services/graphql_service.dart';
import 'login_screen.dart';

class UNvestApp extends StatefulWidget {
  const UNvestApp({super.key});

  @override
  UNvestAppState createState() => UNvestAppState();
}

class UNvestAppState extends State<UNvestApp> {
  @override
  void initState() {
    super.initState();

    AuthenticationService().verify().then((loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeWidget(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
