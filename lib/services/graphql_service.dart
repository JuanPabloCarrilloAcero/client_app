import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/dashboard_model.dart';

class GraphQLService {
  late String graphqlApiUrl;
  late HttpLink httpLink;
  late GraphQLClient _client;

  GraphQLService() {
    graphqlApiUrl = dotenv.env['GRAPHQL_API_URL'] ?? '';
    httpLink = HttpLink(graphqlApiUrl);
    _client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  Future<QueryResult> performQuery(String query) async {
    final options = QueryOptions(
      document: gql(query),
    );

    final result = await _client.query(options);
    return result;
  }

  Future<QueryResult> performMutation(String mutation) async {
    final options = MutationOptions(
      document: gql(mutation),
    );

    final result = await _client.mutate(options);
    return result;
  }

  Future<DashboardModel> fetchDataDashboard() async {

    var data = DashboardModel(
        predictions: []
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
      final predictions = relevantData.map((json) => Prediction.fromJson(json)).cast<Prediction>().toList();
      data.predictions = predictions;
    }


    return data;
  }
}
