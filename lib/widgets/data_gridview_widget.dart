import 'package:flutter/cupertino.dart';

import '../methods/isMobileOrDesktop.dart';

class DataGridviewWidget extends StatelessWidget {
  final List<Widget> body;

  const DataGridviewWidget({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: isMobileOrDesktop() ? 4 : 1,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: body,
    );
  }
}
