import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
         // selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendário',
          //selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_add),
          label: 'Notificações',
         // selectedIconTheme: IconThemeData(),
        ),
        /*BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat Room',
          //selectedIconTheme: IconThemeData(),
        ),*/
        BottomNavigationBarItem(
          icon: Icon(Ionicons.grid_outline),
          label: 'Atividades',
          //selectedIconTheme: IconThemeData(),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
