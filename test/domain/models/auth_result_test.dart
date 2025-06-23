import 'package:flutter_test/flutter_test.dart';
import 'package:teste_flutter/domain/models/auth_result.dart';
import 'package:teste_flutter/domain/models/app_user.dart';

void main() {
  group('AuthResult', () {
    test('deve criar AuthResult com sucesso', () {
      final user =
          AppUser(uid: '1', displayName: 'Test User', email: 'test@test.com');
      final result = AuthResult.success(user);

      expect(result.success, true);
      expect(result.user, user);
      expect(result.message, 'Autenticação realizada com sucesso');
      expect(result.errorCode, null);
    });

    test('deve criar AuthResult com falhas', () {
      const errorMessage = 'Authentication failed';
      const errorCode = 'ERROR_001';
      final result = AuthResult.failure(errorMessage, errorCode: errorCode);

      expect(result.success, false);
      expect(result.message, errorMessage);
      expect(result.errorCode, errorCode);
      expect(result.user, null);
    });

    test('deve criar AuthResult com construtor', () {
      final result = AuthResult(
          success: true,
          message: 'Test message',
          user: AppUser(
              uid: '1', displayName: 'Test User', email: 'test@test.com'),
          errorCode: 'TEST_CODE');

      expect(result.success, true);
      expect(result.message, 'Test message');
      expect(result.user?.uid, '1');
      expect(result.errorCode, 'TEST_CODE');
    });
  });
}
