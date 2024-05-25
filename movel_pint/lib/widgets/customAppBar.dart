import 'package:flutter/material.dart';
import 'package:movel_pint/perfil/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Image.asset(
              'assets/Images/logo.png',
              width: 40,
              height: 40,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileApp()), // Navigate to ModificarPerfil
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
