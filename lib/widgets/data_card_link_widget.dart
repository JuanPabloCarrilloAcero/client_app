import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkContent {
  final String name;
  final String link;

  LinkContent({
    required this.name,
    required this.link,
  });
}

class DataCardLinkWidget extends StatelessWidget {
  const DataCardLinkWidget({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  final List<LinkContent> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.map((value) {
                return InkWell(
                  onTap: () async {

                    if (await canLaunchUrlString(value.link)) {
                      await launchUrlString(value.link);
                    } else {
                      throw 'Could not launch news link';
                    }
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          value.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      // Border below the item
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ));
  }
}
