import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/NotificationCard.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/backend/api_service.dart';

void main() {
  runApp(Notificacoes());
}

class Notificacoes extends StatefulWidget {
  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  List<dynamic> _atividades = [];

  @override
  void initState() {
    super.initState();
    _fetchAtividades();
  }

  Future<void> _fetchAtividades() async {
    try {
      print('Tentando acessar: http://localhost:8000/atividade/listar');
      final data = await ApiService.fetchData('http://localhost:8000/atividade/listar');
      setState(() {
        _atividades = data['data'];
      });
      print('Atividades carregadas com sucesso');
    } catch (e) {
      print('Erro ao carregar atividades: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
      home: VerNotificacoes(_selectedIndex, _onItemTapped, _pageController, _nextPage, _previousPage, _atividades),
    );
  }
}

class VerNotificacoes extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final Function() nextPage;
  final Function() previousPage;
  final List<dynamic> atividades;

  VerNotificacoes(this.selectedIndex, this.onItemTapped, this.pageController, this.nextPage, this.previousPage, this.atividades);

  @override
  Widget build(BuildContext context) {
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
                      'Notificações',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Implementar filtro
                      },
                    ),
                  ],
                ),
              ),
              for (var atividade in atividades) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      atividade['date'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Notificação clicada!');
                  },
                  child: NotificationCard(
                    imageUrl: atividade['imageUrl'],
                    description: atividade['description'],
                    date: atividade['date'],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onItemTapped: onItemTapped,
          ),
        ],
      ),
    );
  }
}
