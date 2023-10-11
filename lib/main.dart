import 'package:client_app/screens/unvest_app.dart';
import 'package:client_app/services/authentication_service.dart';
import 'package:client_app/services/graphql_service.dart';
import 'package:client_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  await dotenv.load(fileName: ".env");

  AuthenticationService authService = AuthenticationService();

  GraphQLService graphQLService = GraphQLService();

  runApp(MyApp(authService: authService, graphQLService: graphQLService));
}

class MyApp extends StatelessWidget {
  final AuthenticationService authService;
  final GraphQLService graphQLService;

  const MyApp(
      {Key? key, required this.authService, required this.graphQLService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'UNvest';

    return MaterialApp(
      title: title,
      home: UNvestApp(authService: authService, graphQLService: graphQLService),
      theme: unvestTheme,
    );
  }
}
