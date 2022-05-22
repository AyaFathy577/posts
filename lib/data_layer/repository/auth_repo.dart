import 'package:posts/data_layer/services/auth_service.dart';

class AuthRepo {
  final AuthService _authService = AuthService();

  Future register(String email, String password) async {
    return _authService.register(email, password);
  }

  Future login(String email, String password) async {
    return _authService.login(email, password);
  }

  signOut() async {
    return _authService.signOut();
  }
}
