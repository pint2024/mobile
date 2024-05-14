import 'package:flutter/material.dart';
import 'package:movel_pint/atividade/atividades.dart';
import 'package:movel_pint/atividade/topicosAtividades.dart';
import 'package:movel_pint/evento/criarEvento.dart';
import 'package:movel_pint/perfil/login.dart';
import 'package:movel_pint/perfil/registo.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/calendario/calendario.dart'; // Importe o arquivo de calendario.dart
import 'perfil/modificar_perfil.dart'; // Importe a página de modificar perfil

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(initialIndex: 0), // Índice inicial para HomePage
    );
  }
}

class HomePage extends StatefulWidget {
  final int initialIndex; // Índice inicial para a BottomNavigationBar
  HomePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navegar para a página de calendário quando o índice do calendário for selecionado
    if (index == 1) { // Se o índice selecionado for 1 (índice do calendário)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalendarScreen()),
      );
    }
  }

  void _nextPage() {
    if (_pageController.page! < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _goToEventFormPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventFormPage()),
    );
  }

  void _goToModificarPerfilPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfilePage1()),
    );
  }

  void _goToLoginPerfilPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _goToRegisterPerfilPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void _goToAtividadesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Atividade()),
    );
  }

  void _goToCategoriesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriesPage()),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 900,
              height: 240,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        child: Image.network(
                          'https://t4.ftcdn.net/jpg/03/84/55/29/360_F_384552930_zPoe9zgmCF7qgt8fqSedcyJ6C6Ye3dFs.jpg',
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 200,
                        child: Image.network(
                          'https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/RE2wSVH_RE4dchU:VP1-539x349?resMode=sharp2&op_usm=1.5,0.65,15,0&qlt=90&fmt=png-alpha',
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 200,
                        child: Image.network(
                          'https://img.freepik.com/fotos-gratis/arvore-solitaria_181624-46361.jpg?w=1060&t=st=171812141722~exp=1712142322~hmac=a0f37d64a060617c99ed647fab3b10e1b8e770402f9cdcfcbaaf92b879e20aa7',
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 80,
                    left: 1,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 20),
                      onPressed: _previousPage,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 1,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, size: 20),
                      onPressed: _nextPage,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyCard(),
          SizedBox(height: 16), // Espaçamento entre o card e o botão
          ElevatedButton(
            onPressed: _goToEventFormPage,
            child: Text('Criar Novo Evento'),
          ),
           ElevatedButton(
                onPressed: _goToModificarPerfilPage,
                child: Text('Modificar Perfil'),
              ),
              ElevatedButton(
                onPressed: _goToLoginPerfilPage,
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: _goToRegisterPerfilPage,
                child: Text('Registar'),
              ),
              ElevatedButton(
                onPressed: _goToAtividadesPage,
                child: Text('Atividades'),
              ),
              ElevatedButton(
                onPressed: _goToCategoriesPage,
                child: Text('Categorias das atividades'),
              ),
          CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
    );
  }
}
