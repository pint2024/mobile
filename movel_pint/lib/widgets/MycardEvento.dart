import 'package:flutter/material.dart';
import 'package:movel_pint/evento/detalhesEvento.dart'; // Importa a página detalhesEvento.dart

class MyCardEvento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Adiciona um GestureDetector para detectar cliques
      onTap: () {
        Navigator.push( // Navega para a página detalhesEvento.dart quando clicado
          context,
          MaterialPageRoute(builder: (context) => EventDetailsPage()), // Substitua DetalhesEvento() pela classe correta se necessário
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
                  backgroundImage: NetworkImage('assets/Images/logo2.png'),
                ),
                title: Text('Título do evento'),
                subtitle: Text('Nome do usuário • Data'),
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
                      image: AssetImage('assets/Images/logo2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Um pouco do texto da atividade'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // Alinhamento à direita
                children: [
                  _buildIconWithCount(Icons.photo_library_outlined, '5'),
                  SizedBox(width: 20), // Espaçamento entre os ícones
                  _buildIconWithCount(Icons.comment_outlined, '5'),
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
