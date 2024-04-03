import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white), 
                    onPressed: () {
            
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Conteúdo da página $_selectedIndex'),
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
