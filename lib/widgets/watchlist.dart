import 'package:flutter/cupertino.dart';

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('Watchlist'),
      ),
    );
  }

}