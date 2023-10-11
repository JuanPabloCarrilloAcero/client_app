import 'package:flutter/material.dart';

class AboutUsWidget extends StatelessWidget {
  const AboutUsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: const <Widget>[
        AboutUsCard(),
      ],
    );

  }
}

class AboutUsCard extends StatelessWidget {
  const AboutUsCard({super.key});


  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 10, // Add shadow to the card for depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add rounded corners
      ),
      child: const Padding(
        padding: EdgeInsets.all(16), // Add padding for spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [// Add vertical spacing
            Text(
              'UNvest is a web investment platform that provides users with a wide range of features, including buying and selling stocks, tracking their investment portfolios, and more. In addition to these features, UNvest offers users relevant stock news, enabling them to make informed decisions and increase confidence in their transactions.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8), // Add additional vertical spacing
            Text(
              'A standout feature of UNvest is its price prediction capability. Using historical statistical data, this feature allows users to access our projections on how prices will behave in the near future.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );

  }

}