import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('assets/Images/logo2.png'),
              ),
              title: Text('Título da Atividade'),
              subtitle: Text('Nome do usuário • Data'),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Row(
      children: [
        Icon(Icons.photo_library_outlined),
        SizedBox(width: 3), // Espaçamento entre o ícone e o número
        Text(
          '5', // Número de imagens (estático por enquanto)
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ],
),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment_outlined),
                      onPressed: () {},
                    ),
                    SizedBox(width: 2), // Espaçamento entre o ícone e o número
                    Text(
                      '5', // Número de comentários (estático por enquanto)
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
