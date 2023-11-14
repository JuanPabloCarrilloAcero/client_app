import 'package:client_app/services/graphql_service.dart';
import 'package:client_app/widgets/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/authentication_service.dart';
import '../widgets/custom/custom_logo_padding.dart';

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
            padding: getCustomPadding(), // Adjust the padding value as needed
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
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _showModal(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                    storage.write(key: "JWT", value: token).then((_) {
                      // The JWT has been written, now write the ID
                      GraphQLService().getID().then((id) {
                        print('ID: $id');
                        return storage.write(key: "ID", value: id);
                      });
                    }).then((_) {
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

  void _showModal(BuildContext context) {
    String nameUser = '';
    String passwordUser = '';
    String roleUser = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  nameUser = value;
                },
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  passwordUser = value;
                },
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              TextField(
                onChanged: (value) {
                  roleUser = value;
                },
                decoration: const InputDecoration(labelText: 'Role'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add code to handle the "Close" button action here
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                print("create");
                GraphQLService()
                    .createUser(nameUser, passwordUser, roleUser)
                    .then((r) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.check,
                          color: Colors
                              .white, // Change the checkmark color to blue
                        ),
                        const SizedBox(width: 10),
                        // Some spacing
                        Text(
                          'The creation was successful with ID: $r',
                          style: const TextStyle(
                              color: Colors
                                  .white), // Change text color to white
                        ),
                      ],
                    ),
                    backgroundColor: Colors
                        .green, // Change the background color to green
                  ),
                ))
                    .catchError((error) =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          // Error icon
                          const SizedBox(width: 10),
                          // Some spacing
                          Text(
                              'An error occurred while saving the user: $error'),
                        ],
                      ), // Set the background color to red for error messages
                    )));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                // Change background color
                foregroundColor: MaterialStateProperty.all(
                    Colors.white), // Change text color
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
