// data/services/firebase_auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_flutter/domain/models/auth_result.dart';
import 'package:teste_flutter/domain/models/register_data.dart';
import '../../domain/models/app_user.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().map((user) {
      return user != null ? AppUser.fromFirebaseUser(user) : null;
    });
  }

  AppUser? get currentUser {
    final user = _auth.currentUser;
    return user != null ? AppUser.fromFirebaseUser(user) : null;
  }

  Future<AuthResult> signInWithCPF({
    required String cpf,
    required String password,
  }) async {
    try {
      final cleanCPF = cpf.replaceAll(RegExp('[^0-9]'), '');

      final email = '$cleanCPF@tokiomarine.app';

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final savedCPF = await _getSavedCPF(credential.user!.uid);
        final appUser = AppUser.fromFirebaseUser(
          credential.user!,
          cpf: savedCPF ?? cleanCPF,
        );

        await _saveUserLocally(appUser);
        return AuthResult.success(appUser);
      }

      return AuthResult.failure('Erro desconhecido no login');
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code, errorCode: e.code);
    } catch (e) {
      return AuthResult.failure('Erro inesperado: $e');
    }
  }

  Future<AuthResult> createUserWithCPF({
    required RegisterData registerData,
  }) async {
    try {
      final validationError = registerData.validationError;
      if (validationError != null) {
        return AuthResult.failure(validationError);
      }

      final cleanCPF = registerData.cpf.replaceAll(RegExp('[^0-9]'), '');

      if (cleanCPF.length != 11) {
        return AuthResult.failure('CPF deve ter 11 dígitos');
      }

      final email = '$cleanCPF@tokiomarine.app';

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: registerData.password,
      );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(registerData.name);

        await credential.user!.reload();
        final updatedUser = _auth.currentUser!;

        final appUser = AppUser.fromFirebaseUser(
          updatedUser,
          cpf: cleanCPF,
        );

        await _saveCPFMapping(updatedUser.uid, cleanCPF);
        await _saveUserLocally(appUser);

        return AuthResult.success(appUser);
      }

      return AuthResult.failure('Erro desconhecido no cadastro');
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code, errorCode: e.code);
    } catch (e) {
      return AuthResult.failure('Erro inesperado: $e');
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return AuthResult.failure('Login cancelado pelo usuário');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final appUser = AppUser.fromFirebaseUser(userCredential.user!);
        await _saveUserLocally(appUser);
        return AuthResult.success(appUser);
      }

      return AuthResult.failure('Erro no login com Google');
    } catch (e) {
      return AuthResult.failure('Erro no login com Google: $e');
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
    await _clearUserData();
  }

  bool get isLoggedIn => _auth.currentUser != null;

  Future<void> _saveCPFMapping(String uid, String cpf) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cpf_$uid', cpf);
  }

  Future<String?> _getSavedCPF(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cpf_$uid');
  }

  Future<void> _saveUserLocally(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', user.toJson().toString());
  }

  Future<AppUser?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('current_user');
    if (userJson != null && currentUser != null) {
      final savedCPF = await _getSavedCPF(currentUser!.uid);
      return AppUser.fromFirebaseUser(_auth.currentUser!, cpf: savedCPF);
    }
    return null;
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');
  }

  bool isValidCPF(String cpf) {
    final cleanCPF = cpf.replaceAll(RegExp('[^0-9]'), '');
    return cleanCPF.length == 11;
  }
}
