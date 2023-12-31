import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_service.dart';

class AuthenticationService {

  Future<String> login(String username, String password) async {
    const String loginMutation = r'''
      mutation {
        loginUsuario(usuario: { nameUser: $nameUser, passwordUser: $passwordUser })
      }
    ''';

    final Map<String, dynamic> variables = {
      'nameUser': username,
      'passwordUser': password,
    };

    final mutatedLoginMutation = loginMutation
        .replaceAll('\$nameUser', '"${variables['nameUser']}"')
        .replaceAll('\$passwordUser', '"${variables['passwordUser']}"');

    final mutationResult =
        await GraphQLService().performMutation(mutatedLoginMutation);

    if (mutationResult.hasException) {
      if (mutationResult.exception is OperationException &&
          mutationResult.exception!.graphqlErrors.isNotEmpty) {
        final graphqlErrorMessage =
            mutationResult.exception?.graphqlErrors[0].message;

        if (graphqlErrorMessage == "400 - undefined") {
          throw Exception("Invalid username or password");
        } else if (graphqlErrorMessage == "404 - undefined") {
          throw Exception("User not found");
        } else {
          throw Exception(graphqlErrorMessage);
        }
      }
      throw mutationResult.exception!;
    } else {
      final token = mutationResult.data?['loginUsuario'];
      return token;
    }
  }

  Future<bool> verify() async {

    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'JWT');
    return jwtToken != null;
  }
}
