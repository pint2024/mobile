import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DetalhesAtividade(),
  ));
}

class DetalhesAtividade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Atividade', style: TextStyle(fontSize: 18.0)),
        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDetailItemWithLabel(
              'Atividade de Exemplo',
              isTitle: true,
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTag('Tecnologia'), // Exemplo de tag
              ],
            ),
            SizedBox(height: 8),
            Image.asset(
              'assets/Images/jauzim.jpg', // Caminho da sua imagem
              height: 160,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            _buildDetailItemWithLabel(
              'Rua Exemplo, Número 456 - Cidade',
            ),
            _buildDetailItemWithLabel(
              '30/06/2024 09:00',
            ),
            SizedBox(height: 16),
            _buildDetailItemLabel('Descrição'),
            _buildDetailItemWithLabel(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Fusce maximus porta sapien, non tempor elit vestibulum a.',
              isDescription: true,
            ),
          ],
        ),
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
