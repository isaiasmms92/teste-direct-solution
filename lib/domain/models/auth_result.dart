import 'app_user.dart';

class AuthResult {
  final bool success;
  final String? message;
  final AppUser? user;
  final String? errorCode;

  AuthResult({
    required this.success,
    this.message,
    this.user,
    this.errorCode,
  });

  factory AuthResult.success(AppUser user) {
    return AuthResult(
      success: true,
      user: user,
      message: 'Autenticação realizada com sucesso',
    );
  }

  factory AuthResult.failure(String message, {String? errorCode}) {
    return AuthResult(
      success: false,
      message: message,
      errorCode: errorCode,
    );
  }
}
