import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
}