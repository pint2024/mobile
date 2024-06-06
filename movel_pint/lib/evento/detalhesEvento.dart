import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

void main() {
  runApp(MaterialApp(
    home: EventoDetailsPage(),
  ));
}

class EventoDetailsPage extends StatefulWidget {
  @override
  _EventoDetailsPageState createState() => _EventoDetailsPageState();
}

class _EventoDetailsPageState extends State<EventoDetailsPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDetailItemWithLabel(
              'Evento de Exemplo',
              isTitle: true,
            ),
            SizedBox(height: 16),
            Image.asset(
              'assets/Images/logo2.png', // Substitua pelo caminho da sua imagem
              height: 160,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            _buildDetailItemWithLabel(
              'Rua Exemplo, Número 123 - Cidade',
            ),
            _buildDetailItemWithLabel(
              '25/05/2024 14:30',
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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
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
}
