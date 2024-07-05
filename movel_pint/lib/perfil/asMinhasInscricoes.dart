import 'package:flutter/material.dart';
import 'package:movel_pint/backend/api_service.dart';

class MinhasInscricoesPage extends StatelessWidget {
 
   Future<void> _fetchEventsForUser() async {
    try {
      final data = await ApiService.listar('participante');
      if (data != null && data['success'] && data['conteudo'] != null) {
        List<int> conteudos = [];
        for (var conteudo in data['conteudo']) {
          if (conteudo['utilizador'] == 1) {
            conteudos.add(conteudo['id']);
          }
        }
        print('IDs dos conteúdos inscritos:');
        conteudos.forEach((id) {
          print('ID: $id');
        });
      } else {
        print('Erro ao buscar conteúdos inscritos: ${data != null ? data['message'] : 'No data returned'}');
      }
    } catch (e) {
      print('Erro ao conectar ao servidor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Inscrições'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _fetchEventsForUser();
          },
          child: Text('Buscar Meus Conteúdos Inscritos'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MinhasInscricoesPage(),
    );
  }
}
