import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendario',
          //selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_add),
          label: 'Notificações',
          //selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'ChatRoom',
          //selectedIconTheme: IconThemeData(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Definições',
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
