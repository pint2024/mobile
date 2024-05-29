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
        SectionTitle(title: 'Saude', onViewMore: () {}),
        SizedBox(height: 10.0),
        SizedBox(
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              myCard('https://t4.ftcdn.net/jpg/03/84/55/29/360_F_384552930_zPoe9zgmCF7qgt8fqSedcyJ6C6Ye3dFs.jpg', 'Saware Ki Hasi'),
              myCard('https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/RE2wSVH_RE4dchU:VP1-539x349?resMode=sharp2&op_usm=1.5,0.65,15,0&qlt=90&fmt=png-alpha', 'Pehle Bhi Main'),
              myCard('https://img.freepik.com/fotos-gratis/arvore-solitaria_181624-46361.jpg?w=1060&t=st=171812141722~exp=1712142322~hmac=a0f37d64a060617c99ed647fab3b10e1b8e770402f9cdcfcbaaf92b879e20aa7', 'Khamoshi'),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        SectionTitle(title: 'Habitação', onViewMore: () {}),
        SizedBox(height: 10.0),
        SizedBox(
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              myCard('https://t4.ftcdn.net/jpg/03/84/55/29/360_F_384552930_zPoe9zgmCF7qgt8fqSedcyJ6C6Ye3dFs.jpg', 'Chahun Main Ya Naa'),
              myCard('https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/RE2wSVH_RE4dchU:VP1-539x349?resMode=sharp2&op_usm=1.5,0.65,15,0&qlt=90&fmt=png-alpha', 'Fitoor'),
              myCard('https://img.freepik.com/fotos-gratis/arvore-solitaria_181624-46361.jpg?w=1060&t=st=1712142322~hmac=a0f37d64a060617c99ed647fab3b10e1b8e770402f9cdcfcbaaf92b879e20aa7', 'Dil Meri Na Sune'),
            ],
          ),
        ),
      ],
    );
  }

  Widget myCard(String imageUrl, String title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
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
