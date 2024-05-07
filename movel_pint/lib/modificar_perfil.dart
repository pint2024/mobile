import 'package:flutter/material.dart';

void main() {
  runApp(UserProfileApp1());
}

class UserProfileApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfilePage1(),
    );
  }
}

class UserProfilePage1 extends StatefulWidget {
  @override
  _UserProfilePageState1 createState() => _UserProfilePageState1();
}

class _UserProfilePageState1 extends State<UserProfilePage1> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Image.asset(
                  'assets/Images/logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://img.freepik.com/vetores-premium/ilustracao-de-avatar-de-estudante-icone-de-perfil-de-usuario-avatar-de-jovem_118339-4402.jpg?w=740'), // Altere para a URL da nova imagem do avatar
            ),
            SizedBox(height: 10),
            Text(
              'Nome do Utilizador', // Substitua pelo nome do usuário
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email: novo.email@exemplo.com',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Telefone: PT +356 123456789',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição (Opcional)',
              ),
              maxLines: 10, // Increase the maximum number of lines
              minLines: 5, // Increase the minimum number of lines
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Confrmar'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Eliminar conta'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                       // Define a cor de fundo para vermelho
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'ChatRoom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Definições',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
