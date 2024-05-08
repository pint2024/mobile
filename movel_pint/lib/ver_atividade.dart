import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

void main() {
  runApp(Atividade());
}

class Atividade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerAtividade(),
    );
  }
}

class VerAtividade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Título da Atividade',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // 
                      },
                    ),
                  ],
                ),
              ),
              MyCard(), 
              MyCard(),
              MyCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavigationBar(
            selectedIndex: 0,
            onItemTapped: (index) {
              // 
            },
          ),
        ],
      ),
    );
  }
}
