import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoriesPage(),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  final List<Category> categories = [
    Category('Saúde', Icons.favorite, Colors.red),
    Category('Desporto', Icons.directions_run, Colors.blue),
    Category('Formação', Icons.menu_book, Colors.green),
    Category('Gastronomia', Icons.restaurant, Colors.orange),
    Category('Transportes', Icons.directions_bus, Colors.purple),
    Category('Lazer', Icons.movie, Colors.teal),
    Category('Habitação', Icons.home, Colors.brown),
    Category('Todos', Icons.playlist_add_check, Colors.amber),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Adicione o CustomAppBar aqui
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Escolher categoria',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryTile(category: categories[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0, // Índice inicial selecionado para o BottomNavigationBar
        onItemTapped: (index) {
          // Aqui você pode adicionar lógica para lidar com o item selecionado
          print('Item $index selecionado');
          // Você pode adicionar mais lógica aqui, como navegação para diferentes telas com base no índice selecionado
        },
      ),
    );
  }
}

class Category {
  final String title;
  final IconData icon;
  final Color color;

  Category(this.title, this.icon, this.color);
}

class CategoryTile extends StatelessWidget {
  final Category category;

  CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle category tile tap here
        // Você pode navegar para uma tela específica da categoria ou realizar outras ações
        print('Categoria selecionada: ${category.title}');
      },
      child: Container(
        padding: EdgeInsets.all(10), // Adicione padding para reduzir o tamanho do contêiner
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 40, // Tamanho do ícone
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              category.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
