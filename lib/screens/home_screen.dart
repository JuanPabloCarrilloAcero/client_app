import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: const Text(
            'Home',
            style: TextStyle(
              color: Colors.black, // Change the text color here
            ),
          ),
        ),
        flexibleSpace: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    const HomeScreen(), // Replace with your home screen widget
              ));
            },
            child: Image.asset(
              'assets/logo.png',
              height: 100,
            ),
          ),
        ),
        leading: PopupMenuButton<String>(
          icon: const Icon(
            Icons.menu, // Use the menu icon
            color: Colors.black, // Change the icon color to black
          ),
          onSelected: (choice) {
            // Handle menu item selection here
            print('Selected: $choice');
          },
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Watchlist',
                child: Text('Watchlist'),
              ),
              const PopupMenuItem<String>(
                value: 'Deposit/Retire',
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
            ];
          },
        ),
        backgroundColor: const Color(0xFFF9FBFA),
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
