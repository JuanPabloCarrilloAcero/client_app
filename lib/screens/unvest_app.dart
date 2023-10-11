import 'package:client_app/services/authentication_service.dart';
import 'package:client_app/widgets/home/home.dart';
import 'package:flutter/material.dart';

import '../services/graphql_service.dart';
import 'login_screen.dart';

class UNvestApp extends StatefulWidget {
  const UNvestApp(
      {super.key, required this.authService, required this.graphQLService});

  final AuthenticationService authService;
  final GraphQLService graphQLService;

  @override
  UNvestAppState createState() => UNvestAppState();
}

class UNvestAppState extends State<UNvestApp> {
  @override
  void initState() {
    super.initState();

    widget.authService.verify().then((loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeWidget(
              graphQLService: widget.graphQLService,
              authService: widget.authService),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(
              authService: widget.authService,
              graphQLService: widget.graphQLService),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
