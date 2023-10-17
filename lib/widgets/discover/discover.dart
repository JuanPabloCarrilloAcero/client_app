import 'package:client_app/widgets/data_gridview_widget.dart';
import 'package:client_app/widgets/discover/widgets/discover_acciones.dart';
import 'package:client_app/widgets/discover/widgets/discover_valuable.dart';
import 'package:flutter/cupertino.dart';

import '../../screens/home_screen.dart';
import '../../services/graphql_service.dart';
import '../data_loader_widget.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen(
      body: DataLoaderWidget(
          fetchData: GraphQLService().fetchDataDiscover,
          builder: (data) {
            return DataGridviewWidget(body: <Widget>[
              DiscoverValuableWidget(valuableStocks: data.valuableStocks),
              DiscoverAccionesWidget(companies: data.companies)
            ]);
          }),
      title: 'Discover',
    );
  }
}
