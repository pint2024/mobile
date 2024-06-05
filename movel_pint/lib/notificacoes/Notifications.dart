import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/NotificationCard.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            title: 'Nova mensagem recebida',
            description: 'Você recebeu uma nova mensagem de exemplo.',
            date: '01/06/2024',
          ),
          NotificationCard(
            title: 'Atualização do sistema',
            description: 'Uma nova atualização está disponível para download.',
            date: '30/05/2024',
          ),
          NotificationCard(
            title: 'Lembrete de evento',
            description: 'Lembrete para o evento importante.',
            date: '28/05/2024',
          ),
        ],
      ),
    );
  }
}
