// guards/auth_guard.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_flutter/data/services/firebase_auth_service.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final authService = Modular.get<FirebaseAuthService>();

    final isLoggedIn = authService.isLoggedIn;

    if (!isLoggedIn) {
      Modular.to.navigate('/');
      return false;
    }

    return true;
  }
}
