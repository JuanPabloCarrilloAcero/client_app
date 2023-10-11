import 'package:flutter/cupertino.dart';

import '../../screens/home_screen.dart';
import '../../services/authentication_service.dart';
import '../../services/graphql_service.dart';
import '../dashboard/dashboard.dart';
import '../data_loader_widget.dart';

class HomeWidget extends StatelessWidget {
  final GraphQLService graphQLService;
  final AuthenticationService authService;

  const HomeWidget(
      {super.key, required this.graphQLService, required this.authService});

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
        body: DataLoaderWidget(
            fetchData: graphQLService.fetchDataDashboard,
            builder: (data) {
              return DashboardWidget(data: data);
            }),
        title: 'Home',
        graphQLService: graphQLService,
        authService: authService);
  }
}
