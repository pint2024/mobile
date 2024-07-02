import 'package:flutter/material.dart';
import 'package:movel_pint/atividade/criarAtividade.dart';
import 'package:movel_pint/atividade/detalhes_atividade.dart';
import 'package:movel_pint/espa%C3%A7o/criarespa%C3%A7o.dart';
import 'package:movel_pint/espa%C3%A7o/detalhesEspaco.dart';
import 'package:movel_pint/evento/criarEvento.dart';
import 'package:movel_pint/evento/detalhesEvento.dart';
import 'package:movel_pint/notificacoes/Notifications.dart';
import 'package:movel_pint/perfil/login.dart';
import 'package:movel_pint/perfil/registo.dart';
import 'package:movel_pint/recomedacao/criarRecomendacao.dart';
import 'package:movel_pint/recomedacao/detalhesRecomendacao.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart'; // Certifique-se que o caminho está correto
import 'package:movel_pint/calendario/calendario.dart'; // Importe o arquivo de calendar

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
  }

  
  void _goToEventFormPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventFormPage()),
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

  void _goToCreateEspacoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpaceFormPage()),
    );
  }

  void _goToCreateRecomendacaoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecommendationFormPage()),
    );
  }

  void _goToCreateAtividadePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateActivityPage()),
    );
  }

  void _goToDetalhesEspacoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpaceDetailsPage()),
    );
  }

  void _goToDetalhesRecomedacaoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecommendationDetailsPage()),
    );
  }

void _goToDetalheEventoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetailsPage()),
    );
  }

  void _goToDetalheAtividadePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActivityDetailsPage(activityId: 1,)),
    );
  }

    void _goToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginApp()),
    );
  }
  
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Integrando a CustomAppBar aqui
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
                          'https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/RE2wSVH_RE4dchU:VP1-539x349?resMode=sharp2&op_usm=1.5,0.65,15,0&qlt=90&fmt=png-alpha',
                        ),
                      ),
                    ],
                  ),
                  /*
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
                  */
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //MyCard(),
          
          SizedBox(height: 16), // Espaçamento entre o card e o botão
          ElevatedButton(
            onPressed: _goToEventFormPage,
            child: Text('Criar Novo Evento'),
          ),
          ElevatedButton(
            onPressed: _goToCreateEspacoPage,
            child: Text('Criar Espaço'),
          ),
          ElevatedButton(
            onPressed: _goToCreateRecomendacaoPage,
            child: Text('Criar recomendação'),
          ),
          ElevatedButton(
            onPressed: _goToCreateAtividadePage,
            child: Text('Criar atividade'),
          ),
          ElevatedButton(
            onPressed: _goToDetalhesEspacoPage,
            child: Text('Detalhes de Espaço'),
          ),
          ElevatedButton(
            onPressed: _goToDetalhesRecomedacaoPage,
            child: Text('Detalhes da Recomendacao'),
          ),
          ElevatedButton(
            onPressed: _goToDetalheEventoPage,
            child: Text('Detalhes do Evento'),
          ),
          ElevatedButton(
            onPressed: _goToDetalheAtividadePage,
            child: Text('Detalhes da Atividade'),
          ),
          ElevatedButton(
            onPressed: _goToRegisterPage,
            child: Text('Registar'),
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
