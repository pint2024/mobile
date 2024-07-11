import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:movel_pint/calendario/calendario.dart';
import 'package:movel_pint/home/homepage.dart';
import 'package:movel_pint/main.dart';
import 'package:movel_pint/Forum/Forum.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendário',
          selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.grid_outline),
          label: 'Forum',
          selectedIconTheme: IconThemeData(),
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageMain()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalendarScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForumPage()),
          );
        } else if (index >= 3 || index < 0) {
          print("ndada");
          
        }
        widget.onItemTapped(index);
      },
    );
  }
}
