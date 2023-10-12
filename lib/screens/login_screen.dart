import 'package:client_app/widgets/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/authentication_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            // Adjust the padding value as needed
            child: Image.asset(
              'assets/logo.png',
              height: 80,
            ),
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

                  AuthenticationService()
                      .login(username, password)
                      .then((token) {
                    // Authentication successful
                    const storage = FlutterSecureStorage();
                    print('Token: $token');
                    storage.write(key: "JWT", value: token).then((value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeWidget(),
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
