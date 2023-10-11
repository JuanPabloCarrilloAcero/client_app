import 'package:client_app/services/graphql_service.dart';
import 'package:client_app/widgets/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/authentication_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationService authService;
  final GraphQLService graphQLService;

  const LoginScreen(
      {super.key, required this.authService, required this.graphQLService});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        flexibleSpace: Center(
          child: Image.asset(
            'assets/logo.png',
            height: 100,
          ),
        ),
        backgroundColor: const Color(0xFFF9FBFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username/Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  authService.login(username, password).then((token) {
                    // Authentication successful
                    const storage = FlutterSecureStorage();
                    storage.write(key: "JWT", value: token).then((value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeWidget(
                              graphQLService: graphQLService,
                              authService: authService),
                        ),
                      );
                    });
                  }).catchError((error) {
                    // Authentication failed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Authentication failed. Please try again. $error'),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
