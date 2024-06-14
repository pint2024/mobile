import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/backend/api_service.dart';

void main() {
  runApp(MaterialApp(
    home: SpaceDetailsPage(),
  ));
}

class SpaceDetailsPage extends StatefulWidget {
  @override
  _SpaceDetailsPageState createState() => _SpaceDetailsPageState();
}

class _SpaceDetailsPageState extends State<SpaceDetailsPage> {
  int _selectedIndex = 3;
  Map<String, dynamic>? _conteudoTipo;
  final int userId = 4; // Definindo o userId internamente

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchConteudoTipo(userId); // Usando o ID definido internamente
  }

  Future<void> _fetchConteudoTipo(int userId) async {
    try {
      final data = await ApiService.fetchData('conteudo/obter/$userId'); // Alterando a rota
      print(data);
      if (data != null) {
        setState(() {
          _conteudoTipo = data?['data'];
        });
        print('Dados carregados com sucesso');
      } else {
        print('Dados não encontrados ou inválidos');
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("joao é gay 3");
  return Scaffold(
    appBar: CustomAppBar(),
    body: _conteudoTipo != null ? _buildContentItem(_conteudoTipo) : Center(child: Text('Nenhum conteúdo disponível')),
    bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
    ),
  );
}

  Widget _buildContentItem(Map<String, dynamic>? item) {
    print(item);
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDetailItemWithLabel(
            item?['titulo'] ?? 'Título não encontrado',
            isTitle: true,
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTag(item?['conteudo_tipo']['tipo']), // Ajuste conforme necessário para outras tags
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: item?['imagem'] != null
                    ? (item!['imagem'].startsWith('http')
                        ? NetworkImage(item['imagem'])
                        : AssetImage('assets/Images/${item['imagem']}')) as ImageProvider
                    : AssetImage('assets/Images/jauzim.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ), 
          SizedBox(height: 16),
          _buildDetailItemWithLabel(
            item?['endereco'] ?? 'Endereço não encontrado',
          ),
          _buildDetailItemWithLabel(
            item?['data_evento'] ?? 'Data não encontrada',
          ),
          SizedBox(height: 16),
          _buildDetailItemLabel('Descrição'),
          _buildDetailItemWithLabel(
            item?['descricao'] ?? 'Descrição não encontrada',
            isDescription: true,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailItemWithLabel(String value, {bool isTitle = false, bool isSubtopic = false, bool isDescription = false}) {
    print("joao é gay");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        value,
        style: TextStyle(
          fontSize: isTitle ? 18 : isSubtopic ? 14 : isDescription ? 12 : 14,
          fontWeight: isTitle || isSubtopic ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDetailItemLabel(String label) {
    print("joao é gay 2");
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    print("joao é gay 1");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
