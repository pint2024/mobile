import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<dynamic>? _comments;
  bool _showAllComments = false; // Estado para controlar a visualização dos comentários
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
          _comments = data?['data']['comentario_conteudo'];
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
    return Scaffold(
      appBar: CustomAppBar(),
      body: _conteudoTipo != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildContentItem(_conteudoTipo!),
                    SizedBox(height: 16),
                    _buildCommentsSection(_comments),
                  ],
                ),
              ),
            )
          : Center(child: Text('Nenhum conteúdo disponível')),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildContentItem(Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDetailItemWithLabel(
          item['titulo'] ?? 'Título não encontrado',
          isTitle: true,
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTag(item['conteudo_tipo']['tipo']), // Tipo de conteúdo
            SizedBox(width: 8),
            _buildTag(item['conteudo_subtopico']['area']), // Área do subtopico
            SizedBox(width: 8),
            _buildTag(item['conteudo_subtopico']['subtopico_topico']['topico']), // Tópico
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: item['imagem'] != null
                  ? (item['imagem'].startsWith('http')
                      ? NetworkImage(item['imagem'])
                      : AssetImage('assets/Images/${item['imagem']}')) as ImageProvider
                  : AssetImage('assets/Images/jauzim.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildDetailItemWithLabel(
          item['endereco'] ?? 'Endereço não encontrado',
        ),
        SizedBox(height: 16),
        _buildDetailItemLabel('Descrição'),
        _buildDetailItemWithLabel(
          item['descricao'] ?? 'Descrição não encontrada',
          isDescription: true,
        ),
        SizedBox(height: 16),
        _buildDetailItemLabel('Criado por'),
        _buildDetailItemWithLabel(
          "${item['conteudo_utilizador']['nome']} ${item['conteudo_utilizador']['sobrenome']} em ${item['data_criacao'].toString().substring(0, 10)}",
          isDescription: true,
        ),
      ],
    );
  }

  Widget _buildCommentsSection(List<dynamic>? comments) {
    if (comments == null || comments.isEmpty) {
      return SizedBox.shrink();
    }

    List<dynamic> visibleComments = _showAllComments ? comments : [comments.first];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDetailItemLabel('Comentários'),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: visibleComments.length,
          itemBuilder: (context, index) {
            return _buildCommentItem(visibleComments[index]);
          },
        ),
        if (comments.length > 1) // Mostrar o botão de expansão se houver mais de um comentário
          TextButton(
            onPressed: () {
              setState(() {
                _showAllComments = !_showAllComments;
              });
            },
            child: Text(
              _showAllComments ? 'Mostrar menos' : 'Mostrar mais',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${comment['utilizador']}',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '${comment['data_criacao']}',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 8),
          Text(
            comment['comentario'] ?? 'Comentário não disponível',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItemWithLabel(String value, {bool isTitle = false, bool isSubtopic = false, bool isDescription = false}) {
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
