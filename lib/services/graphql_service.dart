import 'package:client_app/models/discover_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/dashboard_model.dart';

class GraphQLService {
  late String graphqlApiUrl;
  late HttpLink httpLink;
  late GraphQLClient _client;

  Future<void> _initializeClient() async {
    const storage = FlutterSecureStorage();
    var jwtToken = await storage.read(key: 'JWT') ?? '';

    graphqlApiUrl = dotenv.env['GRAPHQL_API_URL'] ?? '';

    httpLink = HttpLink(
      graphqlApiUrl,
      defaultHeaders: {
        'Authorization': 'Bearer $jwtToken',
      },
    );

    _client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  Future<QueryResult> performQuery(String query) async {
    await _initializeClient();

    final options = QueryOptions(
      document: gql(query),
    );

    final result = await _client.query(options);
    return result;
  }

  Future<QueryResult> performMutation(String mutation) async {
    await _initializeClient();

    final options = MutationOptions(
      document: gql(mutation),
    );

    final result = await _client.mutate(options);
    return result;
  }

  Future<DashboardModel> fetchDataDashboard() async {
    var data = DashboardModel(
      predictions: [],
    );

    const String relevantQuery = r'''
      query {
                getRelevantByTicker (days: 30) {
                    ticker
                    value
                }
            }
    ''';

    final relevantResult = await performQuery(relevantQuery);

    if (relevantResult.hasException) {
      if (relevantResult.exception is OperationException &&
          relevantResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
            relevantResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw relevantResult.exception!;
    } else {
      final relevantData = relevantResult.data?['getRelevantByTicker'];
      final predictions = relevantData
          .map((json) => Prediction.fromJson(json))
          .cast<Prediction>()
          .toList();
      data.predictions = predictions;
    }

    return data;
  }

  Future<DiscoverModel> fetchDataDiscover() async {
    var data = DiscoverModel(
      valuableStocks: [],
    );

    const String valueableQuery = r'''
      query {
                getValuableByTicker (days: 30) {
                    ticker
                    value
                }
            }
    ''';

    final valueableResult = await performQuery(valueableQuery);

    if (valueableResult.hasException) {
      if (valueableResult.exception is OperationException &&
          valueableResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
            valueableResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw valueableResult.exception!;
    } else {
      final valuableData = valueableResult.data?['getValuableByTicker'];
      final valuables = valuableData
          .map((json) => ValuableStock.fromJson(json))
          .cast<ValuableStock>()
          .toList();
      data.valuableStocks = valuables;
    }

    return data;
  }
}
