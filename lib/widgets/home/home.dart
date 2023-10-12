import 'package:flutter/cupertino.dart';

import '../../screens/home_screen.dart';
import '../../services/graphql_service.dart';
import '../dashboard/dashboard.dart';
import '../data_loader_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      body: DataLoaderWidget(
          fetchData: GraphQLService().fetchDataDashboard,
          builder: (data) {
            return DashboardWidget(data: data);
          }),
      title: 'Home',
    );
  }
}
