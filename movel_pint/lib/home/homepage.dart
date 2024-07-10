import 'package:flutter/material.dart';

// Importações dos arquivos de páginas e widgets (exemplo de importações, ajuste conforme sua estrutura)
import 'package:movel_pint/atividade/TodasAtividades.dart';
import 'package:movel_pint/atividade/criarAtividade.dart';
import 'package:movel_pint/espaço/TodosEspacos.dart';
import 'package:movel_pint/espaço/criarespaço.dart';
import 'package:movel_pint/evento/TodosEventos.dart';
import 'package:movel_pint/evento/criarEvento.dart';
import 'package:movel_pint/recomedacao/TodasRecomendacoes.dart';
import 'package:movel_pint/recomedacao/criarRecomendacao.dart';

// Importações de constantes, barra de navegação personalizada e mini cards
import 'package:movel_pint/utils/constants.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/widgets/minicard.dart';

// Importação do serviço de API
import 'package:movel_pint/backend/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageMain(), // Alteração aqui para HomePageMain
    );
  }
}

class HomePageMain extends StatefulWidget {
  @override
  _HomePageMainState createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  int _selectedIndex = 0; // índice inicial selecionado
  final PageController _pageController = PageController();
  List<Map<String, dynamic>> _atividades = [];
  List<Map<String, dynamic>> _eventos = [];
  List<Map<String, dynamic>> _recomendacoes = [];
  List<Map<String, dynamic>> _espacos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchConteudos();
  }

  Future<void> _fetchConteudos() async {
    try {
      print('Chamando API para buscar dados...');
      final data = await ApiService.listar('conteudo');
      print("dados recebidos");
      print('Dados recebidos da API: $data');
      if (data != null) {
        print('Data não é nulo');
        if (data is List) {
          print('Data["data"] é uma lista');
          setState(() {
            _atividades = List<Map<String, dynamic>>.from(data).where((conteudo) => conteudo['tipo'] == 2).toList();
            _eventos = List<Map<String, dynamic>>.from(data).where((conteudo) => conteudo['tipo'] == 1).toList();
            _recomendacoes = List<Map<String, dynamic>>.from(data).where((conteudo) => conteudo['tipo'] == 3).toList();
            _espacos = List<Map<String, dynamic>>.from(data).where((conteudo) => conteudo['tipo'] == 4).toList();
            _isLoading = false; // Dados carregados, alterar o estado de carregamento
          });
        } else {
          print('Data["data"] não é uma lista, é: ${data.runtimeType}');
          setState(() {
            _isLoading = false; // Dados carregados (ou falha), alterar o estado de carregamento
          });
        }
      } else {
        print('Nenhum dado encontrado ou dado malformado');
        setState(() {
          _isLoading = false; // Dados malformados, alterar o estado de carregamento
        });
      }
    } catch (e) {
      print('Erro ao carregar conteúdos: $e');
      setState(() {
        _isLoading = false; // Erro ao carregar dados, alterar o estado de carregamento
      });
    }
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carrossel de imagens
                  _buildImageCarousel(),

                  SizedBox(height: 20.0),

                  // Título "Últimas atividades"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Últimas atividades',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),

                  // Lista de últimas atividades
                  buildSection('Atividades', _atividades, context),
                  buildSection('Eventos', _eventos, context),
                  buildSection('Recomendações', _recomendacoes, context),
                  buildSection('Espaços', _espacos, context),
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget buildSection(String title, List<Map<String, dynamic>> conteudos, BuildContext context) {
    final ScrollController scrollController = ScrollController();

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
                  builder: (context) => TodasAtividades(),
                ),
              );
            } else if (title == 'Eventos') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosEventos(),
                ),
              );
            } else if (title == 'Recomendações') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodasRecomendacoes(),
                ),
              );
            } else if (title == 'Espaços') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodasEspacos(),
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
                  controller: scrollController,
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: conteudos.take(3).length,
                    itemBuilder: (context, index) {
                      final conteudo = conteudos[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MiniCard(
                          imageUrl: conteudo['imagem'] ?? 'assets/Images/imageMissing.jpg',
                          title: conteudo['titulo'] ?? 'Título', atividade: {}, onTap: () {  },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }


Widget _buildImageCarousel() {
  return SizedBox(
    height: 240,
    width: 900,
    child: Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: _atividades.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 300,
              height: 200,
              child: Image.network(
                'https://t4.ftcdn.net/jpg/03/84/55/29/360_F_384552930_zPoe9zgmCF7qgt8fqSedcyJ6C6Ye3dFs.jpg',
                fit: BoxFit.cover,
              ),
            );
            
          },
        ),
      ],
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
                        builder: (context) => RecomendationFormPage(),
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
        /*GestureDetector(
          onTap: onViewMore,
          child: Text(
            'Ver mais...',
            style: TextStyle(fontSize: 14.0, color: Colors.blue),
          ),
        ),*/
      ],
    );
  }
}
