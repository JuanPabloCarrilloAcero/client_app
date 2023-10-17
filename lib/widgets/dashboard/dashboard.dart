import 'package:client_app/models/dashboard_model.dart';
import 'package:client_app/widgets/data_gridview_widget.dart';
import 'package:flutter/cupertino.dart';

import 'widgets/dashboard_balance.dart';
import 'widgets/dashboard_news.dart';
import 'widgets/dashboard_owned_stocks.dart';
import 'widgets/dashboard_predictions.dart';

class DashboardWidget extends StatelessWidget {
  final DashboardModel data;

  const DashboardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DataGridviewWidget(body: <Widget>[
      const DashboardBalanceWidget(),
      const DashboardOwnedStocks(),
      DashboardPredictionsWidget(
        predictions: data.predictions,
      ),
      DashboardNewsWidget(
        news: data.news,
      ),
    ]);
  }
}
