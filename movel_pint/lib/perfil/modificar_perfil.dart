import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movel_pint/perfil/profile.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'dart:io';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
      automaticallyImplyLeading: false,
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
                    MaterialPageRoute(builder: (context) => ProfileApp()),
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

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String _name = "John Doe";
  String _birthday = "01/01/1990";
  String _phoneNumber = "123456789";
  String _instagramName = "john_doe";
  String _email = "john.doe@example.com";
  String _password = "**********";
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _getImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/Images/profile_picture.png') as ImageProvider,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _getImage,
                child: Text("Mudar a sua foto de perfil"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Nome:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Escreva o seu nome",
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Aniversario:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Adicione a sua data de aniversário",
              ),
              onChanged: (value) {
                _birthday = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Numero:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Novo numero de telemovel",
              ),
              onChanged: (value) {
                _phoneNumber = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Nome do intagram:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Insira o nome do instagram",
              ),
              onChanged: (value) {
                _instagramName = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Email:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Novo email",
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Password:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Insira a sua nova password",
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Cancelar"),
                        content: Text("As modificações não serão guardadas"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Navigate to profile page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ProfilePage()),
                              );
                            },
                            child: Text("Continuar"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Guardar"),
                        content: Text("Tem a certeza que quer guardar?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Navigate to profile page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ProfilePage()),
                              );
                            },
                            child: Text("Continuar"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancelar"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Guardar"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0, // Defina o índice correto
        onItemTapped: (int index) {
          // Implemente a lógica para trocar de tela
        },
      ),
    );
  }
}
