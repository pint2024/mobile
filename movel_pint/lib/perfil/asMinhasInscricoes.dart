import 'package:flutter/material.dart';
import 'package:movel_pint/Forum/Forum.dart';
import 'package:movel_pint/atividade/detalhes_atividade.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/calendario/calendario.dart';
import 'package:movel_pint/widgets/MycardAtividade.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

class MinhasInscricoesPage extends StatefulWidget {
  @override
  _MinhasInscricoesPageState createState() => _MinhasInscricoesPageState();
}

class _MinhasInscricoesPageState extends State<MinhasInscricoesPage> {
  int _selectedIndex = 0; 
  List<Map<String, dynamic>> _atividades = [];

  @override
  void initState() {
    super.initState();
    _fetchAndSetAtividades();
  }

  Future<void> _fetchAndSetAtividades() async {
    try {
      final response =
          await ApiService.listar('participante', data: {'utilizador': 1});
      final List<int> conteudoList =
          response.map<int>((item) => item['conteudo'] as int).toList();
      final List<Future<Map<String, dynamic>>> fetchTasks =
          conteudoList.map((conteudoId) async {
        final atividadeResponse =
            await ApiService.obter('conteudo', conteudoId);
        return atividadeResponse as Map<String, dynamic>;
      }).toList();
      final List<Map<String, dynamic>> atividades =
          await Future.wait(fetchTasks);
      setState(() {
        _atividades = atividades;
      });
    } catch (e) {
      print('Erro ao conectar ao servidor: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalendarScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForumPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _atividades.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _atividades.length,
              itemBuilder: (context, index) {
                final atividade = _atividades[index];
                return MyCardAtividade(
                  atividade: atividade,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ActivityDetailsPage(activityId: atividade['id']),
                      ),
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MinhasInscricoesPage(),
    );
  }
}
