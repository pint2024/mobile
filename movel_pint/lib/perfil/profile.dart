import 'package:flutter/material.dart';
import 'package:movel_pint/perfil/asMinhasAtividades.dart';
import 'package:movel_pint/perfil/asMinhasInscricoes.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(userId: 1), // Ensure userId is an int
    );
  }
}

class ProfilePage extends StatefulWidget {
  final int userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  Map<String, dynamic>? _profileData;
  bool _isLoading = false;
  List<String> _meusInteresses = [];
  List<String> _selectedInteresses = []; // Lista para armazenar os interesses selecionados
  List<MultiSelectItem<String>> _allAreas = [];

  @override
  void initState() {
    super.initState();
    _fetchProfileData(widget.userId);
    _buscarMeusInteresses();
    _buscarsubtopicos();
  }

  Future<void> _fetchProfileData(int userId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await ApiService.obter('utilizador', userId);
      if (data != null) {
        setState(() {
          _profileData = data;
          _isLoading = false;
        });
        print('Perfil carregado com sucesso');
      } else {
        print('Dados do perfil não encontrados ou inválidos');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Erro ao carregar perfil: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _buscarMeusInteresses() async {
    var response = await ApiService.listar('interesse', headers: {'Content-Type': 'application/json'}, data: {'utilizador': widget.userId});
    if (response != null) {
      List<dynamic> interesses = response as List<dynamic>;
      setState(() {
        _meusInteresses = interesses.map((item) => item['interesse_subtopico']['area'] as String).toList();
        _selectedInteresses = List.from(_meusInteresses); // Inicializa com os interesses existentes
      });
      print(_meusInteresses);
    } else {
      print('Erro ao buscar interesses');
    }
  }

  Future<void> _buscarsubtopicos() async {
    var response = await ApiService.listar('subtopico');
    if (response != null) {
      List<dynamic> subtopicos = response as List<dynamic>;
      setState(() {
        _allAreas = subtopicos.map((item) => MultiSelectItem<String>(item['area'] as String, item['area'] as String)).toList();
      });
      print(_allAreas);
    } else {
      print('Erro ao buscar subtópicos');
    }
  }

  void updateUserId(int newUserId) {
    setState(() {
      _fetchProfileData(newUserId);
      _buscarMeusInteresses();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleSelected(String area) {
    setState(() {
      if (_selectedInteresses.contains(area)) {
        _selectedInteresses.remove(area);
      } else {
        _selectedInteresses.add(area);
      }
      print('Interesses selecionados: $_selectedInteresses');
    });
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
              if (_isLoading)
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (!_isLoading)
                Column(
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
                    MultiSelectDialogField(
                      items: _allAreas,
                      initialValue: _selectedInteresses,
                      title: Text('Escolha os seus Interesses'),
                      selectedColor: Colors.blue,
                      buttonText: Text('Escolha os seus interesses'),
                      onConfirm: (results) {
                        setState(() {
                          _selectedInteresses = List<String>.from(results);
                        });
                        print('Interesses selecionados: $_selectedInteresses');
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (item) {
                          setState(() {
                            _selectedInteresses.remove(item);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => asMinhasAtividades()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'As minhas Atividades',
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
                                MaterialPageRoute(builder: (context) => MinhasInscricoesPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Inscrito',
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
