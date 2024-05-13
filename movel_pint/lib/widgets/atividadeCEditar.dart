import 'package:flutter/material.dart';

class MyCard2 extends StatelessWidget {
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
              title: Text('Título da Atividade'),
              subtitle: Text('Nome do usuário • Data'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Lógica para editar a atividade
                  // Este onPressed será chamado ao pressionar o ícone de edição
                },
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
