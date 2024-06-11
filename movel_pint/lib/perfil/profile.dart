import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movel_pint/perfil/asMinhasAtividades.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/notificacoes/Notifications.dart';
import 'package:movel_pint/calendario/calendario.dart';
import 'package:movel_pint/main.dart';
import 'package:movel_pint/perfil/modificar_perfil.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  Map<String, dynamic>? _profileData;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final data = await ApiService.fetchData('utilizador/obter/1');
      if (data != null && data['data'] != null) {
        setState(() {
          _profileData = data['data'];
        });
        print('Perfil carregado com sucesso');
      } else {
        print('Dados do perfil não encontrados ou inválidos');
      }
    } catch (e) {
      print('Erro ao carregar perfil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileData != null && _profileData!['imagem'] != null
                    ? (_profileData!['imagem'].startsWith('http')
                        ? NetworkImage(_profileData!['imagem'])
                        : AssetImage(_profileData!['imagem'])) as ImageProvider
                    : AssetImage('assets/Images/jauzim.jpg'),
              ),
              SizedBox(height: 16),
              Text(
                _profileData != null ? _profileData!['nome'] ?? 'Nome não encontrado' : 'Nome não encontrado',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildProfileItem(Icons.tag, 'Tag', _profileData != null ? _profileData!['tag'] ?? 'Tag não encontrada' : 'Tag não encontrada'),
              _buildProfileItem(Icons.email, 'Email', _profileData != null ? _profileData!['email'] ?? 'Email não encontrado' : 'Email não encontrado'),
              if (_profileData != null && _profileData!['linkedin'] != null)
                _buildProfileItem(Icons.link, 'LinkedIn', _profileData!['linkedin']),
              if (_profileData != null && _profileData!['facebook'] != null)
                _buildProfileItem(Icons.facebook, 'Facebook', _profileData!['facebook']),
              if (_profileData != null && _profileData!['instagram'] != null)
                _buildProfileItem(Icons.camera_alt, 'Instagram', _profileData!['instagram']),
              _buildProfileItem(Icons.location_city, 'Centro', _profileData != null ? _profileData!['utilizador_centro']['centro'] ?? 'Centro não encontrado' : 'Centro não encontrado'),
              _buildProfileItem(Icons.person, 'Perfil', _profileData != null ? _profileData!['utilizador_perfil']['perfil'] ?? 'Perfil não encontrado' : 'Perfil não encontrado'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Editar perfil',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyAtividadeprofile()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Atividades',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromRGBO(57, 99, 156, 1.0)),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
