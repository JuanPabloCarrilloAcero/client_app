import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  Future<bool> login(String username, String password) async {
    if (username == 'user' && password == 'password') {
      return true;
    }
    return false;
  }

  Future<bool> verify() async {
    await Future.delayed(const Duration(seconds: 0)); // Adding a 5-second delay

    const storage = FlutterSecureStorage();
    String? jwtToken = await storage.read(key: 'JWT');
    return jwtToken != null;
  }
}
