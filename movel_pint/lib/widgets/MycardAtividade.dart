import 'package:flutter/material.dart';
import 'package:movel_pint/atividade/detalhes_atividade.dart'; // Importa a página detalhesEvento.dart

class MyCardAtividade extends StatelessWidget {
  final Map<String, dynamic> atividade; // Adicionando um campo para atividade

  MyCardAtividade({required this.atividade}); // Adicionando um construtor para aceitar atividade

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Adiciona um GestureDetector para detectar cliques
      onTap: () {
        Navigator.push( // Navega para a página detalhesEvento.dart quando clicado
          context,
          MaterialPageRoute(builder: (context) => ActivityDetailsPage()), // Substitua DetalhesEvento() pela classe correta se necessário
        );
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: atividade['imagem'] != null
                      ? NetworkImage(atividade['imagem'])
                      : AssetImage('assets/Images/logo2.png') as ImageProvider,
                ),
                title: Text(atividade['titulo'] ?? 'Título da atividade'),
                subtitle: Text('${atividade['usuario_nome']} • ${atividade['data']}'),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0), // Preenchimento à direita
                ),
              ),
              SizedBox(height: 8), // Espaçamento entre o título e a imagem
              Center(
                child: Container(
                  width: 400, // Largura desejada para a imagem
                  height: 150, // Altura desejada para a imagem
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: atividade['imagem'] != null
                          ? NetworkImage(atividade['imagem'])
                          : AssetImage('assets/Images/logo2.png') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(atividade['descricao'] ?? 'Um pouco do texto da atividade'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Alinhamento à direita
                children: [
                  _buildIconWithCount(Icons.photo_library_outlined, atividade['num_photos'].toString() ?? '0'),
                  SizedBox(width: 20), // Espaçamento entre os ícones
                  _buildIconWithCount(Icons.comment_outlined, atividade['num_comments'].toString() ?? '0'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData iconData, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        SizedBox(width: 3), // Espaçamento entre o ícone e o número
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
