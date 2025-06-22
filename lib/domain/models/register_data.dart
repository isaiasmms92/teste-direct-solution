class RegisterData {
  final String name;
  final String cpf;
  final String password;

  RegisterData({
    required this.name,
    required this.cpf,
    required this.password,
  });

  bool get isValid {
    return name.isNotEmpty &&
        cpf.isNotEmpty &&
        password.isNotEmpty &&
        password.length >= 6;
  }

  String? get validationError {
    if (name.isEmpty) return 'Nome é obrigatório';
    if (name.length < 2) return 'Nome deve ter pelo menos 2 caracteres';
    if (cpf.isEmpty) return 'CPF é obrigatório';
    if (cpf.replaceAll(RegExp('[^0-9]'), '').length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    if (password.isEmpty) return 'Senha é obrigatória';
    if (password.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    return null;
  }
}
