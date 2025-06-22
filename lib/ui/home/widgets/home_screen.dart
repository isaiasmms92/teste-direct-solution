import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:teste_flutter/ui/home/view_model/home_view_model.dart';
import 'package:teste_flutter/ui/home/widgets/card_widget.dart';
import 'package:teste_flutter/ui/home/widgets/drawer_widget.dart';
import 'package:teste_flutter/ui/login/view_model/login_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Modular.get<HomeViewModel>(),
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, size: 30, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          backgroundColor: const Color.fromARGB(255, 32, 32, 32),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.waves,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(width: 4),
              Text(
                'TOKIO MARINE\nSEGURADORA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Consumer<HomeViewModel>(
              builder: (context, homeViewModel, child) {
                return homeViewModel.showWebView
                    ? kIsWeb
                        ? Container(
                            color: const Color.fromARGB(255, 32, 32, 32),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.open_in_new,
                                    color: Color(0xFF4CAF50),
                                    size: 80,
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    'Site aberto em nova aba',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'O link foi aberto em uma nova aba\ndo seu navegador',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      homeViewModel.closeWebView();
                                    },
                                    icon: const Icon(Icons.home),
                                    label: const Text('Voltar ao Início'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4CAF50),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            color: const Color.fromARGB(255, 32, 32, 32),
                            child: homeViewModel.webViewController != null
                                ? Stack(
                                    children: [
                                      WebViewWidget(
                                        controller:
                                            homeViewModel.webViewController!,
                                      ),
                                      if (homeViewModel.isWebViewLoading)
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 32, 32, 32),
                                          child: const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFF4CAF50)),
                                                ),
                                                SizedBox(height: 16),
                                                Text(
                                                  'Carregando...',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF4CAF50)),
                                    ),
                                  ),
                          )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
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
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white24,
                                    child: Icon(
                                      Icons.person,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Bem-vindo',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          Modular.get<LoginViewModel>()
                                                  .currentUser
                                                  ?.displayName ??
                                              'Não informado',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cotar e Contratar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CardWidget(
                                          icon: Icons.directions_car,
                                          label: 'Automóvel',
                                          color: const Color.fromARGB(
                                              255, 70, 69, 69),
                                          height: 10,
                                          onTap: () {
                                            homeViewModel.openAutoInsurance();
                                          },
                                        ),
                                        const SizedBox(width: 5),
                                        const CardWidget(
                                          icon: Icons.home,
                                          label: 'Residencial',
                                          color:
                                              Color.fromARGB(255, 70, 69, 69),
                                          height: 10,
                                        ),
                                        const SizedBox(width: 5),
                                        const CardWidget(
                                          icon: Icons.health_and_safety_rounded,
                                          label: 'Vida',
                                          color:
                                              Color.fromARGB(255, 70, 69, 69),
                                          height: 10,
                                        ),
                                        const SizedBox(width: 5),
                                        const CardWidget(
                                          icon: Icons.accessible_rounded,
                                          label: 'Acidentes\nPessoais',
                                          color:
                                              Color.fromARGB(255, 70, 69, 69),
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Minha Família',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        height: constraints.maxWidth > 600
                                            ? 350
                                            : null,
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(24),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2A2A2A),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.white12,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 6,
                                                ),
                                              ),
                                              child: IconButton(
                                                icon: const Icon(Icons.add),
                                                color: Colors.white,
                                                iconSize: 30,
                                                onPressed: () {},
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            const Text(
                                              'Adicione aqui membros da sua família e\ncompartilhe os seguros com eles',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                height: 1.4,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Contratados',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            height: constraints.maxWidth > 600
                                                ? 350
                                                : null,
                                            constraints: const BoxConstraints(
                                              minHeight: 200,
                                            ),
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(24),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2A2A2A),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.sentiment_dissatisfied,
                                                  color: Colors.white,
                                                  size: 70,
                                                ),
                                                SizedBox(height: 16),
                                                Text(
                                                  'Você ainda não possui seguros contratados.',
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
