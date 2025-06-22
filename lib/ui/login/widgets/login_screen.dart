import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/ui/login/view_model/login_view_model.dart';
import 'package:teste_flutter/ui/login/widgets/check_box_button.dart';
import 'package:teste_flutter/ui/login/widgets/floating_button.dart';
import 'package:teste_flutter/ui/login/widgets/social_button_custom.dart';
import 'package:teste_flutter/utils/mask_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final loginViewModel =
            ModularWatchExtension(context).read<LoginViewModel>();
        loginViewModel.changeTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildRegisterFields(LoginViewModel loginViewModel) {
    return Column(
      children: [
        TextField(
          controller: loginViewModel.cpfRegisterController,
          inputFormatters: [Mask.cpf],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 32, 32, 32),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: 'CPF',
            hintStyle: const TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: loginViewModel.nomeController,
          keyboardType: TextInputType.name,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 32, 32, 32),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: 'Nome',
            hintStyle: const TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: loginViewModel.senhaRegisterController,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 32, 32, 32),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: 'Senha',
            hintStyle: const TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildLoginFields(LoginViewModel loginViewModel) {
    return Column(
      children: [
        TextField(
          controller: loginViewModel.cpfLoginController,
          inputFormatters: [Mask.cpf],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 32, 32, 32),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: 'CPF',
            hintStyle: const TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: loginViewModel.senhaLoginController,
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 32, 32, 32),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: 'Senha',
            hintStyle: const TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox(LoginViewModel loginViewModel) {
    if (loginViewModel.isLoginTab) {
      return Row(
        children: [
          CheckBoxButton(
            isChecked: loginViewModel.isRememberMeChecked,
            onChanged: (_) => loginViewModel.toggleRememberMe(),
            onTap: loginViewModel.toggleRememberMe,
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Esqueceu a senha?',
              style: TextStyle(
                color: Color.fromARGB(255, 84, 163, 87),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Modular.get<LoginViewModel>(),
      child: Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 42, 161, 46),
                            Colors.yellow,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  )
                ],
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: constraints.maxWidth > 600
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: constraints.maxWidth > 600
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: const Icon(
                                  Icons.waves,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'TOKIO MARINE\nSEGURADORA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            'Bem vindo!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Aqui você gerencia seus seguros e os de seus familiares em poucos cliques!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                          child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Consumer<LoginViewModel>(
                                  builder: (context, loginViewModel, child) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 50),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        constraints: const BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 32, 32, 32),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black45,
                                              blurRadius: 3,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: TabBar(
                                                  labelColor:
                                                      const Color.fromARGB(
                                                          255, 84, 163, 87),
                                                  indicatorColor:
                                                      const Color.fromARGB(
                                                          255, 84, 163, 87),
                                                  unselectedLabelColor:
                                                      Colors.grey,
                                                  indicatorPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12),
                                                  isScrollable: true,
                                                  tabAlignment:
                                                      TabAlignment.start,
                                                  dividerColor:
                                                      Colors.transparent,
                                                  controller: _tabController,
                                                  tabs: const [
                                                    Tab(
                                                      child: Text(
                                                        'Login',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Tab(
                                                      child: Text(
                                                        'Cadastro',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              _tabController.index == 0
                                                  ? _buildLoginFields(
                                                      loginViewModel)
                                                  : _buildRegisterFields(
                                                      loginViewModel),
                                              const SizedBox(height: 20),
                                              _buildRememberMeCheckbox(
                                                  loginViewModel),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                      FloatingButton(
                                        onPressed: loginViewModel.isLoading
                                            ? () {}
                                            : () async {
                                                if (_tabController.index == 0) {
                                                  final success =
                                                      await loginViewModel
                                                          .performLogin();
                                                  if (success) {
                                                    Modular.to
                                                        .navigate('/home');
                                                  } else {
                                                    _showErrorSnackBar(
                                                        loginViewModel
                                                                .errorMessage ??
                                                            'Erro no login');
                                                  }
                                                } else {
                                                  final success =
                                                      await loginViewModel
                                                          .performRegister();
                                                  if (success) {
                                                    Modular.to
                                                        .navigate('/home');
                                                  } else {
                                                    _showErrorSnackBar(
                                                        loginViewModel
                                                                .errorMessage ??
                                                            'Erro no cadastro');
                                                  }
                                                }
                                              },
                                      )
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(height: 50),
                              Consumer<LoginViewModel>(
                                  builder: (context, loginViewModel, child) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.waves,
                                          color: Color(0xFF4CAF50),
                                          size: 50,
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            text: 'tokio\n',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                height: 1),
                                            children: [
                                              TextSpan(
                                                text: 'resolve',
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Acesse através das redes sociais',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SocialButtonCustom(
                                          letter: 'G',
                                          onTap: () async {
                                            final success = await loginViewModel
                                                .loginWithGoogle();
                                            if (success) {
                                              Modular.to.navigate('/home');
                                            } else {
                                              _showErrorSnackBar(loginViewModel
                                                      .errorMessage ??
                                                  'Erro no login com Google');
                                            }
                                          },
                                        ),
                                        const SizedBox(width: 16),
                                        SocialButtonCustom(
                                          letter: 'f',
                                          onTap: () {},
                                        ),
                                        const SizedBox(width: 16),
                                        SocialButtonCustom(
                                          letter: '𝕏',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
