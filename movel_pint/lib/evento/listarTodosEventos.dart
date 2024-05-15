import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/eventoCard.dart';

void main() {
  runApp(EventosApp());
}

class EventosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerEventos(),
    );
  }
}

class VerEventos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          EventCard(
            title: 'Festa de Aniversário',
            date: '15/05/2024',
            time: '19:00',
            location: 'Casa de Festas XYZ',
            description: 'Venha comemorar conosco!',
            imageUrl: 'https://example.com/image1.jpg',
          ),
          EventCard(
            title: 'Workshop de Flutter',
            date: '20/06/2024',
            time: '15:00',
            location: 'Centro de Convenções ABC',
            description: 'Aprenda sobre desenvolvimento com Flutter!',
            imageUrl: 'https://example.com/image2.jpg',
          ),
          EventCard(
            title: 'Concerto de Música Clássica',
            date: '10/07/2024',
            time: '20:30',
            location: 'Teatro Municipal',
            description: 'Uma noite especial com belas melodias!',
            imageUrl: 'https://example.com/image3.jpg',
          ),
          EventCard(
            title: 'Feira de Arte Local',
            date: '05/08/2024',
            time: '10:00',
            location: 'Praça da Cidade',
            description: 'Exposição e venda de obras de artistas locais.',
            imageUrl: 'https://example.com/image4.jpg',
          ),
        ],
      ),
    );
  }
}
