import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/widgets/minicard.dart'; // Importe o MiniCard aqui

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ForumPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Aqui está o CustomAppBar sendo chamado
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          buildHomePage(context),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget buildHomePage(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        SectionTitle(title: 'Atividades', onViewMore: () {}),
        SizedBox(height: 10.0),
        SizedBox(
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MiniCard(
                imageUrl:
                    'assets/Images/jauzim.jpg',
                title: 'Saware Ki Hasi',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Pehle Bhi Main',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Khamoshi',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Khamoshi',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Khamoshi',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Khamoshi',
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        SectionTitle(title: 'Eventos', onViewMore: () {}),
        SizedBox(height: 10.0),
        SizedBox(
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Chahun Main Ya Naa',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Fitoor',
              ),
              MiniCard(
                imageUrl:
                    'assets/Images/logo2.png',
                title: 'Dil Meri Na Sune',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onViewMore;

  SectionTitle({required this.title, required this.onViewMore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onViewMore,
          child: Text(
            'View More',
            style: TextStyle(fontSize: 14.0, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
