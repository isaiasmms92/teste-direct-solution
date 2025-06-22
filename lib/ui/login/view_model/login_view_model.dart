// ui/auth/view_model/firebase_auth_controller.dart
import 'package:flutter/material.dart';
import '../../../data/services/firebase_auth_service.dart';
import '../../../domain/models/app_user.dart';
import '../../../domain/models/register_data.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService;

  LoginViewModel(this._authService) {
    _authService.authStateChanges.listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isLoggedIn => _currentUser != null;

  int _currentTabIndex = 0;
  bool _isRememberMeChecked = false;

  int get currentTabIndex => _currentTabIndex;
  bool get isRememberMeChecked => _isRememberMeChecked;
  bool get isLoginTab => _currentTabIndex == 0;
  bool get isRegisterTab => _currentTabIndex == 1;

  final TextEditingController cpfLoginController = TextEditingController();
  final TextEditingController senhaLoginController = TextEditingController();

  final TextEditingController cpfRegisterController = TextEditingController();
  final TextEditingController senhaRegisterController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();

  @override
  void dispose() {
    cpfLoginController.dispose();
    senhaLoginController.dispose();
    cpfRegisterController.dispose();
    senhaRegisterController.dispose();
    nomeController.dispose();
    super.dispose();
  }

  void changeTab(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      clearError();
      notifyListeners();
    }
  }

  void toggleRememberMe() {
    _isRememberMeChecked = !_isRememberMeChecked;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearFields() {
    cpfLoginController.clear();
    senhaLoginController.clear();
    cpfRegisterController.clear();
    senhaRegisterController.clear();
    nomeController.clear();
    notifyListeners();
  }

  Future<bool> loginWithCPF(String cpf, String password) async {
    _setLoading(true);
    clearError();

    final result = await _authService.signInWithCPF(
      cpf: cpf,
      password: password,
    );

    _setLoading(false);

    if (result.success) {
      _currentUser = result.user;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> performLogin() async {
    clearError();

    final cpfError = validateCPF(cpfLoginController.text);
    if (cpfError != null) {
      _errorMessage = cpfError;
      notifyListeners();
      return false;
    }

    final passwordError = validatePassword(senhaLoginController.text);
    if (passwordError != null) {
      _errorMessage = passwordError;
      notifyListeners();
      return false;
    }

    final success = await loginWithCPF(
      cpfLoginController.text,
      senhaLoginController.text,
    );

    if (success) {
      if (_isRememberMeChecked) {
        notifyListeners();
      } else {
        clearFields();
      }
      return success;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String cpf,
    required String password,
  }) async {
    _setLoading(true);
    clearError();

    final registerData = RegisterData(
      name: name,
      cpf: cpf,
      password: password,
    );

    final result =
        await _authService.createUserWithCPF(registerData: registerData);

    _setLoading(false);

    if (result.success) {
      _currentUser = result.user;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> performRegister() async {
    clearError();

    final nameError = validateName(nomeController.text);
    if (nameError != null) {
      _errorMessage = nameError;
      notifyListeners();
      return false;
    }

    final cpfError = validateCPF(cpfRegisterController.text);
    if (cpfError != null) {
      _errorMessage = cpfError;
      notifyListeners();
      return false;
    }

    final passwordError = validatePassword(senhaRegisterController.text);
    if (passwordError != null) {
      _errorMessage = passwordError;
      notifyListeners();
      return false;
    }

    return await register(
      name: nomeController.text,
      cpf: cpfRegisterController.text,
      password: senhaRegisterController.text,
    );
  }

  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    clearError();

    final result = await _authService.signInWithGoogle();

    _setLoading(false);

    if (result.success) {
      _currentUser = result.user;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> performGoogleLogin() async {
    clearError();
    return await loginWithGoogle();
  }

  Future<void> logout() async {
    _setLoading(true);
    await _authService.signOut();
    _currentUser = null;
    _setLoading(false);
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _currentUser = _authService.currentUser;
    notifyListeners();
  }

  String? validateCPF(String cpf) {
    final cleanCPF = cpf.replaceAll(RegExp('[^0-9]'), '');
    if (cleanCPF.isEmpty) return 'CPF é obrigatório';
    if (cleanCPF.length != 11) return 'CPF deve ter 11 dígitos';
    if (!_authService.isValidCPF(cpf)) return 'CPF inválido';
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'Senha é obrigatória';
    if (password.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    return null;
  }

  String? validateName(String name) {
    if (name.isEmpty) return 'Nome é obrigatório';
    if (name.length < 2) return 'Nome deve ter pelo menos 2 caracteres';
    return null;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
