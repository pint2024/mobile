import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/MycardAtividade.dart';
import 'package:movel_pint/widgets/MycardAtividadeEditar.dart';
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
      home: asMinhasAtividades(),
    );
  }
}

class asMinhasAtividades extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<asMinhasAtividades> {
  int _selectedIndex = 2;
  PageController _pageController = PageController(initialPage: 0);
  List<Map<String, dynamic>> _conteudos = [];
  bool _isLoading = true; 
  String? idAtividade; 
  int _selectedFilterIndex = 0; 

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

  void _handleFilterSelection(int index) {
    setState(() {
      _selectedFilterIndex = index;
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
    print('Dados recebidos da API: $data');
    if (data != null) {
      print('Data não é nulo');
      if (data is List) {
        print('Data["data"] é uma lista');
        setState(() {
          // Filtrando conteúdos apenas do utilizador 1 (supondo 'userId' como chave)
          _conteudos = List<Map<String, dynamic>>.from(data)
              .where((conteudo) => conteudo['utilizador'] == 1)
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

  void _onCardTap(String id) {
    setState(() {
      idAtividade = id;
    });
    print('ID da atividade selecionada: $idAtividade');
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
      onCardTap: _onCardTap, // Passando a função para manipular o toque no cartão
      selectedFilterIndex: _selectedFilterIndex, // Passando o índice do filtro selecionado
    );
  }
}

class VerAtividades extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final Function(int) handleFilterSelection;
  final List<Map<String, dynamic>> conteudos;
  final bool isLoading; // Adicionando o parâmetro isLoading
  final Function(String) onCardTap; // Adicionando a função de callback
  final int selectedFilterIndex; // Índice do filtro selecionado

  const VerAtividades({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.pageController,
    required this.nextPage,
    required this.previousPage,
    required this.handleFilterSelection,
    required this.conteudos,
    required this.isLoading, // Inicializando o parâmetro
    required this.onCardTap, // Inicializando o parâmetro
    required this.selectedFilterIndex, // Inicializando o parâmetro
  });

  @override
  Widget build(BuildContext context) {
    print('Construindo VerAtividades...');
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Exibindo a rodinha de carregamento
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Os meus conteúdos',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PopupMenuButton<int>(
                          icon: const Icon(Icons.filter_list),
                          onSelected: handleFilterSelection,
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                            PopupMenuItem<int>(
                              value: 0,
                              child: Text('Todos'),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text('Eventos'),
                            ),
                            PopupMenuItem<int>(
                              value: 2,
                              child: Text('Atividades'),
                            ),
                            PopupMenuItem<int>(
                              value: 3,
                              child: Text('Recomendações'),
                            ),
                            PopupMenuItem<int>(
                              value: 4,
                              child: Text('Espaços'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16), 

                  // Exibir seção de Eventos (tipo = 1)
                  if (selectedFilterIndex == 0 || selectedFilterIndex == 1)
                    _buildSection(
                      title: 'Eventos',
                      backgroundColor: Color(0xFFE0E0E0),
                      conteudos: conteudos.where((conteudo) => conteudo['tipo'] == 1).toList(),
                    ),
                  SizedBox(height: 16),

                  // Exibir seção de Atividades (tipo = 2)
                  if (selectedFilterIndex == 0 || selectedFilterIndex == 2)
                    _buildSection(
                      title: 'Atividades',
                      backgroundColor: Color(0xFFE0E0E0), 
                      conteudos: conteudos.where((conteudo) => conteudo['tipo'] == 2).toList(),
                    ),
                  SizedBox(height: 16), 

                  // Exibir seção de Recomendações (tipo = 3)
                  if (selectedFilterIndex == 0 || selectedFilterIndex == 3)
                    _buildSection(
                      title: 'Recomendações',
                      backgroundColor: Color(0xFFE0E0E0), 
                      conteudos: conteudos.where((conteudo) => conteudo['tipo'] == 3).toList(),
                    ),
                  SizedBox(height: 16),

                  // Exibir seção de Espaços (tipo = 4)
                  if (selectedFilterIndex == 0 || selectedFilterIndex == 4)
                    _buildSection(
                      title: 'Espaços',
                      backgroundColor: Color(0xFFE0E0E0),
                      conteudos: conteudos.where((conteudo) => conteudo['tipo'] == 4).toList(),
                    ),
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Color backgroundColor,
    required List<Map<String, dynamic>> conteudos,
  }) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center( 
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, 
                ),
              ),
            ),
          ),
          Column(
            children: conteudos
                .map((conteudo) => MyCardAtividadeComEditar(
                      atividade: conteudo,
                      onTap: () => onCardTap(conteudo['id'].toString()), onEdit: () {  },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
