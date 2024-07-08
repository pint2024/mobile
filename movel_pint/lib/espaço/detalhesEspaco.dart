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
  int _selectedIndex = 2;
  Map<String, dynamic>? _conteudoTipo;
  List<dynamic>? _comments;
  bool _showAllComments = false;
  final int userId = 4;

  TextEditingController _commentController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchConteudoTipo(userId);
  }

  Future<void> _fetchConteudoTipo(int userId) async {
    try {
      final data = await ApiService.obter('conteudo', userId);
      print(data);
      if (data != null) {
        setState(() {
          _conteudoTipo = data;
          _comments = data?['comentario_conteudo'];
        });
        print('Dados carregados com sucesso');
      } else {
        print('Dados não encontrados ou inválidos');
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  Future<Map<String, dynamic>?> _postComment() async {
    Map<String, dynamic> commentData = {
      'comentario': _commentController.text,
      'conteudo': userId,
      'utilizador': 1, // ID do usuário estático
    };

    try {
      final response = await ApiService.postData('comentario/criar', commentData);
      print(response);
      return response;
    } catch (e) {
      print('Erro ao enviar comentário: $e');
      return null;
    }
  }

  Future<void> _deleteComment(int commentId) async {
    try {
      await ApiService.deleteData('comentario/remover/$commentId');
      setState(() {
        _comments!.removeWhere((comment) => comment['id'] == commentId);
      });
    } catch (e) {
      print('Erro ao remover comentário: $e');
    }
  }

  Future<void> _confirmDeleteComment(int commentId) async {
    // Mostrar um diálogo de confirmação
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: Text("Tem certeza que deseja apagar o comentário?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
            TextButton(
              child: Text("Excluir"),
              onPressed: () {
                _deleteComment(commentId);
                Navigator.of(context).pop(); // Fechar o diálogo
              },
            ),
          ],
        );
      },
    );
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
                    SizedBox(height: 16),
                    _buildCommentInput(),
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

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
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
          if (comments.length > 1)
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
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    // Parse da data no formato ISO 8601 para DateTime
    DateTime commentDate = DateTime.parse(comment['data_criacao']);

    // Formatando a data no formato desejado (data e hora)
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(commentDate);

    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${comment['utilizador']}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _confirmDeleteComment(comment['id']),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            formattedDate, // Usando a data formatada
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

  Widget _buildCommentInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Adicione um comentário',
              border: InputBorder.none,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _postComment().then((_) {
              setState(() {
                _fetchConteudoTipo(userId); // Atualiza os comentários após enviar um novo
                _commentController.clear();
              });
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Enviar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
