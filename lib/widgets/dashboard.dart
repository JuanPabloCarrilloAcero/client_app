import 'package:flutter/cupertino.dart';

import 'dashboard_balance.dart';
import 'dashboard_news.dart';
import 'dashboard_owned_stocks.dart';
import 'dashboard_predictions.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: const <Widget>[
        DashboardBalanceWidget(),
        DashboardOwnedStocks(),
        DashboardPredictionsWidget(),
        DashboardNewsWidget(),
      ],
    );
  }
}