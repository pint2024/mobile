import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/MycardAtividade.dart';
import 'package:movel_pint/widgets/atividadeCEditar.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';


void main() {
  runApp(TodasAtividades());
}

class TodasAtividades extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<TodasAtividades> {
  int _selectedIndex = 3;
  PageController _pageController = PageController(initialPage: 0);

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

  void _handleFilterSelection(String value) {
    // Aqui você pode adicionar lógica para aplicar o filtro selecionado
    print('Filtro selecionado: $value');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerAtividades(_selectedIndex, _onItemTapped, _pageController, _nextPage, _previousPage, _handleFilterSelection),
    );
  }
}

class VerAtividades extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final PageController pageController;
  final Function() nextPage;
  final Function() previousPage;
  final Function(String) handleFilterSelection;

  VerAtividades(this.selectedIndex, this.onItemTapped, this.pageController, this.nextPage, this.previousPage, this.handleFilterSelection);

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
                    Text(
                      'Atividades',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.filter_list),
                      onSelected: (String value) {
                        handleFilterSelection(value);
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Mais recentes',
                          child: Text('Mais recentes'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Mais antigas',
                          child: Text('Mais antigas'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'A-Z',
                          child: Text('A-Z'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Z-A',
                          child: Text('Z-A'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyCardAtividade(),
              MyCardAtividade(),
              MyCardAtividade(),
              MyCardAtividade(),
              MyCardAtividade(),
              MyCardAtividade(),
              MyCardAtividade(),
              MyCardAtividade(),
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
