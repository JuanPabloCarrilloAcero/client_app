class AuthenticationService {

  Future<bool> login(String username, String password) async {

    if (username == 'user' && password == 'password') {
      return true;
    }
    return false;

  }
}
