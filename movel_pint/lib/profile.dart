import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: UserProfilePage(),
  ));
}

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nome do Utilizador'), // Altere para o nome do usuário desejado
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('URL_DA_NOVA_IMAGEM_DO_AVATAR'), // Altere para a URL da nova imagem do avatar
            ),
            SizedBox(height: 10),
            Text('Novo Nome', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), // Altere para o novo nome do usuário
            Text('novo.email@exemplo.com', style: TextStyle(fontSize: 16)), // Altere para o novo email do usuário
            Text('PT +356 123456789', style: TextStyle(fontSize: 16)), // Altere para o novo número de telefone do usuário
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição (Opcional)',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Modificar'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Terminar sessão'),
            ),
          ],
        ),
      ),
    );
  }
}

