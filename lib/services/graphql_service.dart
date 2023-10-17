import 'package:client_app/models/discover_model.dart';
import 'package:client_app/widgets/data_card_stock_modal_widget.dart';
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
      news: [],
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

    const String newsQuery = r'''
      query {
        allNoticias {
         article {
          titulo,
          url
          }
        }
      }
    ''';

    final newsResult = await performQuery(newsQuery);

    if (newsResult.hasException) {
      if (newsResult.exception is OperationException &&
          newsResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
            newsResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw newsResult.exception!;
    } else {
      final newsData = newsResult.data?['allNoticias'];
      final news = newsData
          .map((json) => News.fromJson(json['article']))
          .cast<News>()
          .toList();
      data.news = news;
    }

    return data;
  }

  Future<DiscoverModel> fetchDataDiscover() async {
    var data = DiscoverModel(
      valuableStocks: [],
      companies: [],
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

    const String companyQuery = r'''
      query {
        getEmpresas {
          _id,
          descripcion,
          direccion,
          industria,
          nombre,
          sector,
          ticker,
        }
      }
    ''';

    final companyResult = await performQuery(companyQuery);

    if (companyResult.hasException) {
      if (companyResult.exception is OperationException &&
          companyResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
            companyResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw companyResult.exception!;
    } else {
      final companyData = companyResult.data?['getEmpresas'];
      final companies = companyData
          .map((json) => Company.fromJson(json))
          .cast<Company>()
          .toList();
      data.companies = companies;
    }

    return data;
  }

  Future<String> getID() async {

    const String idQuery = r'''
      query {
        getIDUsuario 
      }
    ''';

    final idResult = await performQuery(idQuery);

    if (idResult.hasException) {
      if (idResult.exception is OperationException &&
          idResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
            idResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw idResult.exception!;
    } else {
      final idData = idResult.data?['getIDUsuario'];
      return idData;
    }
  }

  Future<String?> depositRetire (bool isRetire, String amount) async {

    String date = DateTime.now().toString();
    int transactionType = isRetire ? 2 : 1;
    double transactionAmount = double.parse(amount
        .replaceAll('\$', '')
        .replaceAll(',', ''));

    if (transactionAmount <= 0) {
      throw Exception('Amount must be greater than 0');
    }

    const storage = FlutterSecureStorage();
    String? id = await storage.read(key: 'ID');

    const String createMutation = r'''
      mutation {
        createOperacion ( operacion: { 
            fecha: $fecha,
            tipo: $tipo,
            cantidad: $cantidad,
            id_usuario: $id_usuario
          }
        ) {
            id
        }
      }
    ''';

    final Map<String, dynamic> variables = {
      'fecha': date,
      'tipo': transactionType,
      'cantidad': transactionAmount,
      'id_usuario': id,
    };

    final mutatedCreateMutation = createMutation
        .replaceAll('\$fecha', '"${variables['fecha']}"')
        .replaceAll('\$tipo', '${variables['tipo']}')
        .replaceAll('\$cantidad', '${variables['cantidad']}')
        .replaceAll('\$id_usuario', '${variables['id_usuario']}');

    final mutationResult =
      await GraphQLService().performMutation(mutatedCreateMutation);

    if (mutationResult.hasException) {
      if (mutationResult.exception is OperationException &&
          mutationResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
        mutationResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw mutationResult.exception!;
    } else {
      return mutationResult.data?['createOperacion']['id'].toString();
    }

  }

  Future<String?> buyStock (StockDTO stock, String amount, String action) async {

    String date = DateTime.now().toString();
    int transactionType = action == 'buy' ? 1 : 2;
    double valorAccion = double.parse(stock.price);
    double transactionAmount = double.parse(amount
        .replaceAll(',', ''));
    const storage = FlutterSecureStorage();
    String? idUsuario = await storage.read(key: 'ID');
    String idEmpresa = stock.id;


    const String buyMutation = r'''
      mutation {
        createTransaccion ( transaccion: {
          fecha: $fecha,
          tipo: $tipo,
          valor_accion: $valor_accion,
          cantidad: $cantidad,
          id_usuario: $id_usuario,
          id_empresa: $id_empresa
          }) {
            id
        }
      }
    ''';

    final Map<String, dynamic> variables = {
      'fecha': date,
      'tipo': transactionType,
      'valor_accion': valorAccion,
      'cantidad': transactionAmount,
      'id_usuario': idUsuario,
      'id_empresa': idEmpresa,
    };

    final mutatedBuyMutation = buyMutation
        .replaceAll('\$fecha', '"${variables['fecha']}"')
        .replaceAll('\$tipo', '${variables['tipo']}')
        .replaceAll('\$valor_accion', '${variables['valor_accion']}')
        .replaceAll('\$cantidad', '${variables['cantidad']}')
        .replaceAll('\$id_usuario', '${variables['id_usuario']}')
        .replaceAll('\$id_empresa', '"${variables['id_empresa']}"');

    final mutationResult = await GraphQLService().performMutation(mutatedBuyMutation);

    if (mutationResult.hasException) {
      if (mutationResult.exception is OperationException &&
          mutationResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
        mutationResult.exception?.graphqlErrors[0].message;

        throw Exception(graphqlErrorMessage);
      }
      throw mutationResult.exception!;
    } else {
      return mutationResult.data?['createTransaccion']['id'].toString();
    }

  }

}
