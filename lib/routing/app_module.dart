import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_flutter/data/services/firebase_auth_service.dart';
import 'package:teste_flutter/routing/guards/auth_guard.dart';
import 'package:teste_flutter/ui/home/view_model/home_view_model.dart';
import 'package:teste_flutter/ui/home/widgets/home_screen.dart';
import 'package:teste_flutter/ui/login/view_model/login_view_model.dart';

import 'package:teste_flutter/ui/login/widgets/login_screen.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(() => FirebaseAuthService());

    i.addSingleton(() => LoginViewModel(i.get<FirebaseAuthService>()));

    i.addSingleton(() => HomeViewModel());

    i.addSingleton(() => AuthGuard());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const LoginScreen());
    r.child('/home', child: (context) => const HomeScreen());
  }
}
