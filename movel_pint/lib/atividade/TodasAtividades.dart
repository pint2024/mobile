import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/MycardAtividade.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/backend/api_service.dart';

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
  List<Map<String, dynamic>> _conteudos = [];
  bool _isLoading = true; // Variável para controlar o estado de carregamento

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
    print('Filtro selecionado: $value');
  }

  @override
  void initState() {
    super.initState();
    _fetchConteudos();
  }

  Future<void> _fetchConteudos() async {
    try {
      print('Chamando API para buscar dados...');
      final data = await ApiService.listar('conteudo');
      print("dados recevidos");
      print('Dados recebidos da API: $data');
      if (data != null) {
        print('Data não é nulo');
        if (data is List) {
          print('Data["data"] é uma lista');
          setState(() {
            _conteudos = List<Map<String, dynamic>>.from(data)
                .where((conteudo) => conteudo['tipo'] == 2)
                .toList();
            _isLoading = false; // Dados carregados, alterar o estado de carregamento
          });
        } else {
          print('Data["data"] não é uma lista, é: ${data.runtimeType}');
        }
      } else {
        print('Nenhum dado encontrado ou dado malformado');
        setState(() {
          _isLoading = false; // Falha ao carregar dados, alterar o estado de carregamento
        });
      }
    } catch (e) {
      print('Erro ao carregar conteúdos: $e');
      setState(() {
        _isLoading = false; // Erro ao carregar dados, alterar o estado de carregamento
      });
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
      conteudos: _conteudos,
      isLoading: _isLoading, // Passando o estado de carregamento para o widget VerAtividades
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
  final List<Map<String, dynamic>> conteudos;
  final bool isLoading; // Adicionando o parâmetro isLoading

  const VerAtividades({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.pageController,
    required this.nextPage,
    required this.previousPage,
    required this.handleFilterSelection,
    required this.conteudos,
    required this.isLoading, // Inicializando o parâmetro
  });

  @override
  Widget build(BuildContext context) {
    print('Construindo VerAtividades...');
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Exibindo a rodinha de carregamento
          : SingleChildScrollView(
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
                    conteudos.isNotEmpty
                        ? Column(
                            children: conteudos
                                .map((conteudo) => MyCardAtividade(atividade: conteudo))
                                .toList(),
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
