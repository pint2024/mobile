import 'package:flutter/material.dart';
import 'package:movel_pint/atividade/detalhes_atividade.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';

void main() {
  runApp(Atividade());
}

class Atividade extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  int _selectedFilterIndex = 0;
  int _selectedIndex = 3;
  PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerAtividade(_selectedFilterIndex, _onItemTapped, _pageController, _nextPage, _previousPage),
    );
  }
}

class VerAtividade extends StatefulWidget {
  final int initialFilterIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final Function() nextPage;
  final Function() previousPage;

  VerAtividade(this.initialFilterIndex, this.onItemTapped, this.pageController, this.nextPage, this.previousPage);

  @override
  _VerAtividadeState createState() => _VerAtividadeState();
}

class _VerAtividadeState extends State<VerAtividade> {
  int _selectedIndex = 0;
  Map<String, dynamic>? _atividade;

  @override
  void initState() {
    super.initState();
    _fetchAtividade();
  }

  Future<void> _fetchAtividade() async {
    try {
      print('Tentando acessar: http://localhost:8000/atividade/obter/1');
      final data = await ApiService.fetchData('http://localhost:8000/atividade/obter/1');
      setState(() {
        _atividade = data['data'];
      });
      print('Atividade carregada com sucesso');
    } catch (e) {
      print('Erro ao carregar atividade: $e');
    }
  }

  void _navigateToDetails(int atividadeId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetalhesAtividade(atividadeId: atividadeId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Atividade',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterOptions(context);
                      },
                    ),
                  ],
                ),
              ),
              if (_atividade == null)
                CircularProgressIndicator()
              else
                for (var conteudo in _atividade!['conteudo_atividade'])
                  MyCard(
                    titulo: conteudo['titulo'],
                    descricao: conteudo['descricao'],
                    imagem: 'http://10.0.2.2:8000/${conteudo['imagem']}',
                    dataCriacao: conteudo['data_criacao'],
                    nomeUsuario: 'Nome do Usuário', // Substituir pelo nome real do usuário se disponível
                    numFotos: 5, // Substituir pelo número real de fotos se disponível
                    numComentarios: 5, // Substituir pelo número real de comentários se disponível
                    onTap: () => _navigateToDetails(conteudo['id']), // Adicione a navegação
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index;
                widget.onItemTapped(index);
              });
            },
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromSize(
        Rect.fromPoints(
          Offset(MediaQuery.of(context).size.width - 100, 60),
          Offset(MediaQuery.of(context).size.width - 20, 80),
        ),
        Size(MediaQuery.of(context).size.width, 40),
      ),
      items: [
        for (int i = 0; i < 8; i++)
          PopupMenuItem(
            value: i,
            child: Text('Filtro ${i + 1}'),
          ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedIndex = value;
          widget.onItemTapped(value);
        });
      }
    });
  }
}
