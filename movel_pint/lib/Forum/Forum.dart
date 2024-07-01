import 'package:flutter/material.dart';
import 'package:movel_pint/atividade/TodasAtividades.dart';
import 'package:movel_pint/atividade/criarAtividade.dart';
import 'package:movel_pint/espaço/criarespaço.dart';
import 'package:movel_pint/espaço/todosEspacos.dart'; // Importe a página TodosEspacos aqui
import 'package:movel_pint/evento/TodosEventos.dart';
import 'package:movel_pint/evento/criarEvento.dart';
import 'package:movel_pint/recomedacao/TodasRecomendacoes.dart';
import 'package:movel_pint/recomedacao/criarRecomendacao.dart';
import 'package:movel_pint/utils/constants.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/widgets/minicard.dart'; // Importe o MiniCard aqui

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ForumPage> {
  int _selectedIndex = 3;
  final PageController _pageController = PageController();

  String _selectedOption = ''; // Estado para armazenar a opção selecionada

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          buildHomePage(context),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget buildHomePage(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fórum',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildAddButton(), // Adiciona o botão "Adicionar" ao lado do título "Fórum"
          ],
        ),
        SizedBox(height: 20.0), // Espaço entre o botão e a seção de atividades
        buildSection('Atividades', Icons.sports_soccer, context),
        buildSection('Eventos', Icons.event, context),
        buildSection('Recomendações', Icons.thumb_up, context),
        buildSection('Espaços', Icons.location_city, context),
      ],
    );
  }

  Widget buildSection(String title, IconData iconData, BuildContext context) {
    final ScrollController scrollController = ScrollController(); // Adicione o ScrollController

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: title,
          onViewMore: () {
            if (title == 'Atividades') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodasAtividades(), // Navegue para TodasAtividades quando o título for "Atividades"
                ),
              );
            } else if (title == 'Eventos') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosEventos(), // Navegue para TodosEventos quando o título for "Eventos"
                ),
              );
            } else if (title == 'Recomendações') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodasRecomendacoes(), // Navegue para TodasRecomendacoes quando o título for "Recomendações"
                ),
              );
            } else if (title == 'Espaços') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosEspacos(), // Navegue para TodosEspacos quando o título for "Espaços"
                ),
              );
            }
          },
        ),
        SizedBox(height: 10.0),
        SizedBox(
          height: 200.0,
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: scrollController, // Passe o ScrollController aqui
                  thumbVisibility: true, // Mostra sempre a barra de rolagem
                  child: ListView.builder(
                    controller: scrollController, // Passe o ScrollController aqui também
                    scrollDirection: Axis.horizontal,
                    itemCount: 6, // Número de itens, ajuste conforme necessário
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MiniCard(
                          imageUrl: 'assets/Images/logo2.png',
                          title: '$title $index',
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0), // Espaçamento entre cartões e barra de rolagem
            ],
          ),
        ),
        SizedBox(height: 20.0), // Espaço adicional entre seções
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        _showOptionsDialog(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Adicionar',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.add, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione uma opção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Atividades'),
                  onTap: () {
                    Navigator.pop(context); 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateActivityPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Eventos'),
                  onTap: () {
                    Navigator.pop(context); 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventFormPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.thumb_up),
                  title: Text('Recomendações'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendationFormPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('Espaços'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpaceFormPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option; 
    });
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewMore;

  SectionTitle({required this.title, required this.onViewMore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onViewMore,
          child: Text(
            'Ver mais...',
            style: TextStyle(fontSize: 14.0, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
