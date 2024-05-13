import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clínicas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Text('A', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextField(decoration: InputDecoration(labelText: 'Nome')),
                TextField(decoration: InputDecoration(labelText: 'Assunto')),
                TextField(decoration: InputDecoration(labelText: 'Tópicos (ex: esportes/acomodação)')),
                TextField(decoration: InputDecoration(labelText: 'Email da pessoa que criou')),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
                    Text('1'),
                    IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
