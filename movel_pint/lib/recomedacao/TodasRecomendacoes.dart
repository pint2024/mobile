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
      home: TodasRecomendacoes(),
    );
  }
}

class TodasRecomendacoes extends StatefulWidget {
  @override
  _RecomendacaoState createState() => _RecomendacaoState();
}

class _RecomendacaoState extends State<TodasRecomendacoes> {
  int _selectedIndex = 2;
  PageController _pageController = PageController(initialPage: 0);
  List<Map<String, dynamic>> _conteudos = []; 
  List<Map<String, dynamic>> _filteredConteudos = []; 
  bool _isLoading = true; 
  String? idAtividade; 
  String _selectedFilter = 'Mais recentes'; 

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
    setState(() {
      _selectedFilter = value;
      _applyFilter();
    });
  }

  void _applyFilter() {
    setState(() {
      if (_selectedFilter == 'Mais recentes') {
        _filteredConteudos.sort((a, b) => b['data_criacao'].compareTo(a['data_criacao']));
      } else if (_selectedFilter == 'Mais antigas') {
        _filteredConteudos.sort((a, b) => a['data_criacao'].compareTo(b['data_criacao']));
      } else if (_selectedFilter == 'A-Z') {
        _filteredConteudos.sort((a, b) => a['titulo'].compareTo(b['titulo']));
      } else if (_selectedFilter == 'Z-A') {
        _filteredConteudos.sort((a, b) => b['titulo'].compareTo(a['titulo']));
      }
    });
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
      print("dados recebidos");
      print('Dados recebidos da API: $data');
      if (data != null) {
        print('Data não é nulo');
        if (data is List) {
          print('Data["data"] é uma lista');
          setState(() {
            _conteudos = List<Map<String, dynamic>>.from(data)
                .where((conteudo) => conteudo['tipo'] == 3)
                .toList();
            _filteredConteudos = List<Map<String, dynamic>>.from(_conteudos);
            _applyFilter();
            _isLoading = false; 
          });
        } else {
          print('Data["data"] não é uma lista, é: ${data.runtimeType}');
          setState(() {
            _isLoading = false; 
          });
        }
      } else {
        print('Nenhum dado encontrado ou dado malformado');
        setState(() {
          _isLoading = false; 
        });
      }
    } catch (e) {
      print('Erro ao carregar conteúdos: $e');
      setState(() {
        _isLoading = false; 
      });
    }
  }

  void _onCardTap(String id) {
    setState(() {
      idAtividade = id;
    });
    print('ID da atividade selecionada: $idAtividade');
  }

  @override
  Widget build(BuildContext context) {
    print('Construindo widget VerRecomendacoes...');
    return VerRecomendacoes(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
      pageController: _pageController,
      nextPage: _nextPage,
      previousPage: _previousPage,
      handleFilterSelection: _handleFilterSelection,
      conteudos: _filteredConteudos, 
      isLoading: _isLoading, 
      onCardTap: _onCardTap, 
    );
  }
}

class VerRecomendacoes extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final Function(String) handleFilterSelection;
  final List<Map<String, dynamic>> conteudos; 
  final bool isLoading; 
  final Function(String) onCardTap; 

  const VerRecomendacoes({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.pageController,
    required this.nextPage,
    required this.previousPage,
    required this.handleFilterSelection,
    required this.conteudos, 
    required this.isLoading, 
    required this.onCardTap, 
  });

  @override
  Widget build(BuildContext context) {
    print('Construindo VerRecomendacoes...');
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) 
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
                            'Recomendações',
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
                                .map((conteudo) => MyCardAtividade(
                                      atividade: conteudo,
                                      onTap: () => onCardTap(conteudo['id'].toString()),
                                    ))
                                .toList(),
                          )
                        : const Text('Nenhuma recomendação encontrada'),
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
