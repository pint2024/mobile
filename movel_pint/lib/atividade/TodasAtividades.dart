import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/MycardAtividade.dart';
import 'package:movel_pint/widgets/atividadeCEditar.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/backend/api_service.dart'; // Certifique-se de que o caminho está correto

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodasAtividades(),
    );
  }
}

class TodasAtividades extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<TodasAtividades> {
  int _selectedIndex = 3;
  PageController _pageController = PageController(initialPage: 0);
  List<dynamic> _atividades = []; // Lista para armazenar as atividades

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _nextPage() {
    if (_pageController.page! < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _handleFilterSelection(String value) {
    // Aqui você pode adicionar lógica para aplicar o filtro selecionado
    print('Filtro selecionado: $value');
  }

  @override
  void initState() {
    super.initState();
    _fetchAtividades();
  }

  Future<void> _fetchAtividades() async {
    try {
      print('Chamando API para buscar dados...');
      final data = await ApiService.fetchData('conteudo/obter/1');
      print('Dados recebidos da API: $data');
      if (data != null) {
        print('Data não é nulo');
        if (data.containsKey('data')) {
          print('Data contém a chave "data"');
          if (data['data'] is List) {
            print('Data["data"] é uma lista');
            setState(() {
              _atividades = List<dynamic>.from(data['data']);
            });
          } else {
            print('Data["data"] não é uma lista, é: ${data['data'].runtimeType}');
          }
        } else {
          print('Data não contém a chave "data"');
        }
      } else {
        print('Nenhum dado encontrado ou dado malformado');
      }
    } catch (e) {
      print('Erro ao carregar atividades: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Construindo widget VerAtividades...');
    return VerAtividades(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      pageController: _pageController,
      nextPage: _nextPage,
      previousPage: _previousPage,
      handleFilterSelection: _handleFilterSelection,
      atividades: _atividades, // Passando a lista de atividades para o widget VerAtividades
    );
  }
}

class VerAtividades extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final Function(String) handleFilterSelection;
  final List<dynamic> atividades; // Adicionando um parâmetro para receber as atividades

  const VerAtividades({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.pageController,
    required this.nextPage,
    required this.previousPage,
    required this.handleFilterSelection,
    required this.atividades, // Inicializando o parâmetro
  });

  @override
  Widget build(BuildContext context) {
    print('Construindo VerAtividades...');
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Atividades',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.filter_list),
                      onSelected: (String value) {
                        handleFilterSelection(value);
                      },
                      itemBuilder: (BuildContext context) => const <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Mais recentes',
                          child: Text('Mais recentes'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Mais antigas',
                          child: Text('Mais antigas'),
                        ),
                        PopupMenuItem<String>(
                          value: 'A-Z',
                          child: Text('A-Z'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Z-A',
                          child: Text('Z-A'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Verificando se há atividades
              atividades.isNotEmpty
                  ? Column(
                      children: atividades.map((atividade) {
                        return MyCardAtividade(atividade: atividade);
                      }).toList(),
                    )
                  : const Text('Nenhuma atividade encontrada'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }
}
