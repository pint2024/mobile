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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Altura personalizada da barra de navegação
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 228, 61, 61), // Cor de fundo preta
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16), // Espaçamento à esquerda
                child: Image.asset(
                  '../Images/logo.png', 
                  width: 40,
                  height: 40,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.account_circle, color: Colors.white), // Ícone do perfil
                    onPressed: () {
                      // Adicione ação ao ícone do perfil
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Conteúdo da página'),
      ),
    );
  }
}
