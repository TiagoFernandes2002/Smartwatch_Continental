import 'package:flutter/material.dart';
import 'package:flutter_continental/pages/alerts_page.dart';
import 'package:flutter_continental/pages/notifications_page.dart';
import 'package:flutter_continental/pages/avarias_page.dart';
import 'package:flutter_continental/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_continental/main.dart';  // Importar o arquivo principal onde a função getUserRole está localizada

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<PageViewWidget> {
  final PageController _pageController = PageController(initialPage: 1);
  int _activePage = 0;

  // Lista padrão de páginas para o funcionário
  List<Widget> _pages = [
    const NotificationsPage(),
    const WelcomePage(role: 'default'),
    const AlertsPage()
  ];

  @override
  void initState() {
    super.initState();

    // Buscar a role do usuário atualmente logado
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      getUserRole(user).then((role) {
        if (role == "supervisor") {
          // Se a role do usuário é supervisor, ajustar a lista de páginas
          setState(() {
            _pages = [
              const NotificationsPage(),
              const WelcomePage(role: 'supervisor'),
              const AvariasPage()
            ];
          });
        } else if (role == "funcionario") {
          // Se a role do usuário é funcionario, ajustar a lista de páginas
          setState(() {
            _pages = [
              const NotificationsPage(),
              const WelcomePage(role: 'funcionario'),
              const AlertsPage()
            ];
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          )
        ],
      ),
    );
  }
}
