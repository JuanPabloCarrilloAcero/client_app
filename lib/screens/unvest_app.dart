import 'package:client_app/screens/home_screen.dart';
import 'package:client_app/services/authentication_service.dart';
import 'package:flutter/material.dart';

class UNvestApp extends StatefulWidget {
  const UNvestApp({super.key});

  @override
  UNvestAppState createState() => UNvestAppState();
}

class UNvestAppState extends State<UNvestApp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username/Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text;
                final password = _passwordController.text;

                final isAuthenticated =
                    await AuthenticationService().login(username, password);

                if (isAuthenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Authentication failed. Please try again.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.primary
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
