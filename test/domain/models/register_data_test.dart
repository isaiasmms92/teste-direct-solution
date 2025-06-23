import 'package:flutter_test/flutter_test.dart';
import 'package:teste_flutter/domain/models/register_data.dart';

void main() {
  group('RegisterData', () {
    test(
        'isValid deve retornar verdadeiro quando todos os campos forem válidos',
        () {
      final data = RegisterData(
        name: 'Isaias Silva',
        cpf: '12345678901',
        password: '123456',
      );
      expect(data.isValid, true);
    });

    test('isValid deve retornar falso quando CPF estiver vazio', () {
      final data = RegisterData(
        name: 'Isaias Silva',
        cpf: '',
        password: '123456',
      );
      expect(data.isValid, false);
    });

    test('isValid deve retornar falso quando nome estiver vazio', () {
      final data = RegisterData(
        name: '',
        cpf: '12345678901',
        password: '123456',
      );
      expect(data.isValid, false);
    });

    test('isValid deve retornar falso quando password estiver vazio', () {
      final data = RegisterData(
        name: 'Isaias Silva',
        cpf: '12345678901',
        password: '',
      );
      expect(data.isValid, false);
    });

    test(
        'validationError deve retornar nulo quando todos os campos forem válidos',
        () {
      final data = RegisterData(
        name: 'John Doe',
        cpf: '12345678901',
        password: '123456',
      );
      expect(data.validationError, null);
    });

    test('validationError deve retornar mensagem de erro para nome inválido',
        () {
      final data = RegisterData(
        name: '',
        cpf: '12345678901',
        password: '123456',
      );
      expect(data.validationError, 'Nome é obrigatório');
    });

    test('validationError deve retornar mensagem de erro para CPF inválido',
        () {
      final data = RegisterData(
        name: 'John Doe',
        cpf: '123',
        password: '123456',
      );
      expect(data.validationError, 'CPF deve ter 11 dígitos');
    });

    test('validationError deve retornar mensagem de erro para senha inválida',
        () {
      final data = RegisterData(
        name: 'John Doe',
        cpf: '12345678901',
        password: '123',
      );
      expect(data.validationError, 'Senha deve ter pelo menos 6 caracteres');
    });
  });
}
