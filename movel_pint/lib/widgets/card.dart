import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('assets/Images/logo2.png'),
            ),
            title: Text('Título da Atividade'),
            subtitle: Text('Nome do usuário • Data'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Um pouco do texto da atividade'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
