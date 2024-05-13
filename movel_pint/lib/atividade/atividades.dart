import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

void main() {
  runApp(Atividade());
}

class Atividade extends StatefulWidget {
  @override
  _AtividadeState createState() => _AtividadeState();
}

class _AtividadeState extends State<Atividade> {
  int _selectedFilterIndex = 0;
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
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterOptions(context);
                      },
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < 8; i++)
                if (_selectedIndex == 0 || _selectedIndex == i)
                  MyCard(),
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
