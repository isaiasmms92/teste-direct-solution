import 'package:flutter_test/flutter_test.dart';
import 'package:teste_flutter/domain/models/app_user.dart';

void main() {
  group('AppUser', () {
    test('deve criar uma instância do AppUser com os parâmetros necessários',
        () {
      final user = AppUser(uid: '123');

      expect(user.uid, '123');
      expect(user.email, null);
      expect(user.displayName, null);
      expect(user.photoURL, null);
      expect(user.cpf, null);
    });

    test('deve criar uma instância do AppUser com todos os parâmetros', () {
      final user = AppUser(
          uid: '123',
          email: 'test@test.com',
          displayName: 'Test User',
          photoURL: 'http://photo.url',
          cpf: '12345678900');

      expect(user.uid, '123');
      expect(user.email, 'test@test.com');
      expect(user.displayName, 'Test User');
      expect(user.photoURL, 'http://photo.url');
      expect(user.cpf, '12345678900');
    });

    test('deve converter para JSON', () {
      final user = AppUser(
          uid: '123',
          email: 'test@test.com',
          displayName: 'Test User',
          photoURL: 'http://photo.url',
          cpf: '12345678900');

      final json = user.toJson();
      final fromJson = AppUser.fromJson(json);

      expect(fromJson.uid, user.uid);
      expect(fromJson.email, user.email);
      expect(fromJson.displayName, user.displayName);
      expect(fromJson.photoURL, user.photoURL);
      expect(fromJson.cpf, user.cpf);
    });
  });
}
