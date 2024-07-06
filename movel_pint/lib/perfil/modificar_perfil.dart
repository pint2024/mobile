import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movel_pint/perfil/profile.dart'; // Certifique-se de ajustar o import conforme necessário
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

class ProfileEditScreen extends StatefulWidget {
  final Map<String, dynamic> profileData; // Dados iniciais do perfil

  ProfileEditScreen({required this.profileData});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _linkedinController;
  late TextEditingController _facebookController;
  late TextEditingController _instagramController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profileData['nome']);
    _surnameController = TextEditingController(text: widget.profileData['sobrenome'] ?? '');
    _emailController = TextEditingController(text: widget.profileData['email']);
    _linkedinController = TextEditingController(text: widget.profileData['linkedin'] ?? '');
    _facebookController = TextEditingController(text: widget.profileData['facebook'] ?? '');
    _instagramController = TextEditingController(text: widget.profileData['instagram'] ?? '');
    _passwordController = TextEditingController(); // Não mostraremos a senha atual aqui
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _linkedinController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    try {
      // Preparar dados atualizados do perfil
      Map<String, dynamic> updatedProfile = {
        'id': widget.profileData['id'],
        'nome': _nameController.text,
        'sobrenome': _surnameController.text,
        'email': _emailController.text,
        'linkedin': _linkedinController.text,
        'facebook': _facebookController.text,
        'instagram': _instagramController.text,
        // A senha não será atualizada aqui por questões de segurança
      };

      // Atualizar perfil na API
      await ApiService.updateProfile(updatedProfile);

      // Exibir mensagem de sucesso
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Sucesso"),
          content: Text("Perfil atualizado com sucesso."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
                Navigator.pop(context); // Fechar a tela de edição de perfil
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      // Em caso de erro, exibir mensagem
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Erro"),
          content: Text("Não foi possível atualizar o perfil. Tente novamente mais tarde."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
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
                backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/Images/jauzim.jpg') as ImageProvider,
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
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Escreva o seu nome",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Sobrenome:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(
                hintText: "Escreva o seu sobrenome",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Email:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Novo email",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "LinkedIn:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _linkedinController,
              decoration: InputDecoration(
                hintText: "Insira o seu LinkedIn",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Facebook:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _facebookController,
              decoration: InputDecoration(
                hintText: "Insira o seu Facebook",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Instagram:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _instagramController,
              decoration: InputDecoration(
                hintText: "Insira o seu Instagram",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Insira a sua nova password",
              ),
              obscureText: true, // Para ocultar a senha
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Voltar para a tela anterior
                  },
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: _saveChanges,
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
