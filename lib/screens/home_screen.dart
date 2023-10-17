import 'package:client_app/screens/login_screen.dart';
import 'package:client_app/widgets/about_us.dart';
import 'package:client_app/widgets/deposit_retire/deposit_retire.dart';
import 'package:client_app/widgets/discover/discover.dart';
import 'package:client_app/widgets/home/home.dart';
import 'package:client_app/widgets/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widgets/custom/custom_logo_padding.dart';

class HomeScreen extends StatelessWidget {
  final Widget body;
  final String title;

  const HomeScreen({super.key, required this.body, required this.title});

  void _navigateToScreens(BuildContext context, String option) {
    Widget screen;
    if (option == 'Watchlist') {
      screen = const HomeScreen(body: WatchlistWidget(), title: 'Watchlist');
    } else if (option == 'Deposit / Retire') {
      screen = const HomeScreen(
          body: DepositRetireWidget(), title: 'Deposit / Retire');
    } else if (option == 'Portfolio') {
      screen = const HomeScreen(body: WatchlistWidget(), title: 'Portfolio');
    } else if (option == 'Discover') {
      screen = const DiscoverWidget();
    } else if (option == 'AboutUs') {
      screen = const HomeScreen(body: AboutUsWidget(), title: 'About Us');
    } else if (option == 'Profile') {
      screen = const HomeScreen(body: WatchlistWidget(), title: 'Profile');
    } else {
      screen = const HomeWidget();
    }

    if (option == 'Logout') {
      const storage = FlutterSecureStorage();
      storage.delete(key: "JWT").then((_) {
        storage.delete(key: "ID");
      }).then((value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black, // Change the text color here
            ),
          ),
        ),
        flexibleSpace: Center(
          child: GestureDetector(
            onTap: () {
              _navigateToScreens(context, 'Home');
            },
            child: Padding(
              padding: getCustomPadding(), // Adjust the padding value as needed
              child: Image.asset(
                'assets/logo.png',
                height: 80,
              ),
            ),
          ),
        ),
        leading: PopupMenuButton<String>(
          icon: const Icon(
            Icons.menu, // Use the menu icon
            color: Colors.black, // Change the icon color to black
          ),
          onSelected: (choice) {
            _navigateToScreens(context, choice);
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Watchlist',
                child: Text('Watchlist'),
              ),
              const PopupMenuItem<String>(
                value: 'Deposit / Retire',
                child: Text('Deposit / Retire'),
              ),
              const PopupMenuItem<String>(
                value: 'Portfolio',
                child: Text('Portfolio'),
              ),
              const PopupMenuItem<String>(
                value: 'Discover',
                child: Text('Discover'),
              ),
              const PopupMenuItem<String>(
                value: 'AboutUs',
                child: Text('About Us'),
              ),
              const PopupMenuItem<String>(
                value: 'Profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ];
          },
        ),
        backgroundColor: const Color(0xFFF9FBFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: body,
      ),
    );
  }
}
