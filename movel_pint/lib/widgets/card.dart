/*import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('assets/Images/logo2.png'),
              ),
              title: Text('Título da Atividade'),
              subtitle: Text('Nome do usuário • Data'),
            ),
            const SizedBox(height: 8), // Espaçamento entre o título e a imagem
            Center(
              child: Container(
                width: 400, // Largura desejada para a imagem
                height: 150, // Altura desejada para a imagem
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Images/logo2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Um pouco do texto da atividade'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Alinhamento à direita
              children: [
                _buildIconWithCount(Icons.photo_library_outlined, '5'),
                const SizedBox(width: 20), // Espaçamento entre os ícones
                _buildIconWithCount(Icons.comment_outlined, '5'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData iconData, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        const SizedBox(width: 3), // Espaçamento entre o ícone e o número
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}*/

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String imagem;
  final String dataCriacao;
  final String nomeUsuario;
  final int numFotos;
  final int numComentarios;

  MyCard({
    required this.titulo,
    required this.descricao,
    required this.imagem,
    required this.dataCriacao,
    required this.nomeUsuario,
    required this.numFotos,
    required this.numComentarios,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('assets/Images/logo2.png'),
              ),
              title: Text(titulo),
              subtitle: Text('$nomeUsuario • $dataCriacao'),
            ),
            const SizedBox(height: 8), // Espaçamento entre o título e a imagem
            Center(
              child: Container(
                width: 400, // Largura desejada para a imagem
                height: 150, // Altura desejada para a imagem
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagem),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(descricao),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Alinhamento à direita
              children: [
                _buildIconWithCount(Icons.photo_library_outlined, numFotos.toString()),
                const SizedBox(width: 20), // Espaçamento entre os ícones
                _buildIconWithCount(Icons.comment_outlined, numComentarios.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData iconData, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        const SizedBox(width: 3), // Espaçamento entre o ícone e o número
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Função para criar um widget MyCard a partir dos dados JSON
MyCard createCardFromJson(Map<String, dynamic> json) {
  var atividade = json['data']['conteudo_atividade'][0];
  return MyCard(
    titulo: atividade['titulo'],
    descricao: atividade['descricao'],
    imagem: 'http://localhost:8000/${atividade['imagem']}', // URL completa da imagem
    dataCriacao: atividade['data_criacao'],
    nomeUsuario: 'Nome do Usuário', // Substituir pelo nome real do usuário se disponível
    numFotos: 5, // Substituir pelo número real de fotos se disponível
    numComentarios: 5, // Substituir pelo número real de comentários se disponível
  );
}

