import 'package:client_app/widgets/discover/widgets/discover_acciones.dart';
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
            return GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: <Widget>[
                DiscoverAccionesWidget(valuableStocks: data.valuableStocks),
                const Text(
                    "Acciones (al dar click se abre un modal con la info de la acción)"),
              ],
            );
          }),
      title: 'Discover',
    );
  }
}
