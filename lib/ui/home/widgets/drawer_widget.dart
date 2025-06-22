import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_flutter/ui/home/view_model/home_view_model.dart';
import 'package:teste_flutter/ui/home/widgets/drawer_menu_item_widget.dart';
import 'package:teste_flutter/ui/login/view_model/login_view_model.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Modular.get<LoginViewModel>()
                                      .currentUser
                                      ?.displayName ??
                                  'Usuário',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'PESSOA FÍSICA',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerMenuItem(
                  icon: Icons.home_outlined,
                  title: 'Home/Seguro',
                  onTap: () {
                    Modular.to.pop();
                    Modular.get<HomeViewModel>().goToHome();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.assignment_outlined,
                  title: 'Minhas Contratações',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.favorite_outline,
                  title: 'Meus Sinistros',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.people_outline,
                  title: 'Minha Família',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Meus Bens',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.payment_outlined,
                  title: 'Pagamentos',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Corretores',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.check_circle_outline,
                  title: 'Validar Boleto',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.phone_outlined,
                  title: 'Telefones Importantes',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Configurações',
                  onTap: () {
                    Modular.to.pop();
                  },
                ),
                DrawerMenuItem(
                  icon: Icons.logout,
                  title: 'Sair',
                  onTap: () {
                    Modular.to.pop();
                    Modular.get<LoginViewModel>().logout();
                    Modular.to.navigate('/');
                  },
                  textColor: const Color(0xFF4CAF50),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF4CAF50),
                  Color(0xFFFFEB3B),
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Dúvidas?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Entre em contato conosco através\ndos nossos canais oficiais',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
