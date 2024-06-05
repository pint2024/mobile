/*
import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:movel_pint/atividade/detalhes_atividade.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  final List<String> images = [
    'https://via.placeholder.com/400x300.png?text=Evento+1',
    'https://via.placeholder.com/400x300.png?text=Evento+2',
    'https://via.placeholder.com/400x300.png?text=Evento+3',
    'https://via.placeholder.com/400x300.png?text=Evento+4',
    'https://via.placeholder.com/400x300.png?text=Evento+5',
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      Column(
        children: [
          SizedBox(height: 16.0), // Adiciona um espaçamento de 16 pixels
          /*CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3), // Define o intervalo de 3 segundos entre as transições automáticas
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  );
                },
              );
            }).toList(),
          ),*/
          Expanded(
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Atividade 1'),
                    subtitle: Text('Detalhes da atividade 1'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Atividade 2'),
                    subtitle: Text('Detalhes da atividade 2'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Atividade 3'),
                    subtitle: Text('Detalhes da atividade 3'),
                  ),
                ),
                // Adicione mais atividades aqui
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recomendações de Lugares',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.network(
                      'https://via.placeholder.com/50x50.png?text=Imagem+1',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text('Lugar 1'),
                    subtitle: Text('Descrição breve do evento no lugar 1. Local: Cidade 1'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.network(
                      'https://via.placeholder.com/50x50.png?text=Imagem+2',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text('Lugar 2'),
                    subtitle: Text('Descrição breve do evento no lugar 2. Local: Cidade 2'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Image.network(
                      'https://via.placeholder.com/50x50.png?text=Imagem+3',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text('Lugar 3'),
                    subtitle: Text('Descrição breve do evento no lugar 3. Local: Cidade 3'),
                  ),
                ),
                // Adicione mais recomendações aqui
              ],
            ),
          ),
        ],
      ),
      Center(child: Text('Calendário')),
      VerAtividade(),
      Center(child: Text('Mais')),
    ];

    return Scaffold(
      appBar: CustomAppBar(), // Utilize o CustomAppBar aqui
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class VerAtividade extends StatefulWidget {
  @override
  _VerAtividadeState createState() => _VerAtividadeState();
}

class _VerAtividadeState extends State<VerAtividade> {
  int _selectedIndex = 0;
  Map<String, dynamic>? _atividade;

  @override
  void initState() {
    super.initState();
    _fetchAtividade();
  }

  Future<void> _fetchAtividade() async {
    try {
      print('Tentando acessar: http://localhost:8000/atividade/obter/1');
      final data = await ApiService.fetchData('http://localhost:8000/atividade/obter/1');
      setState(() {
        _atividade = data['data'];
      });
      print('Atividade carregada com sucesso');
    } catch (e) {
      print('Erro ao carregar atividade: $e');
    }
  }


  void _navigateToDetails(int atividadeId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetalhesAtividade(atividadeId: atividadeId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Atividade',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterOptions(context);
                      },
                    ),
                  ],
                ),
              ),
              if (_atividade == null)
                CircularProgressIndicator()
              else
                for (var conteudo in _atividade!['conteudo_atividade'])
                  MyCard(
                    titulo: conteudo['titulo'],
                    descricao: conteudo['descricao'],
                    imagem: 'http://10.0.2.2:8000/${conteudo['imagem']}',
                    dataCriacao: conteudo['data_criacao'],
                    nomeUsuario: 'Nome do Usuário', // Substituir pelo nome real do usuário se disponível
                    numFotos: 5, // Substituir pelo número real de fotos se disponível
                    numComentarios: 5, // Substituir pelo número real de comentários se disponível
                    onTap: () => _navigateToDetails(conteudo['id']), // Adicione a navegação
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
            // Chamar onItemTapped na HomePage
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          });
        },
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromSize(
        Rect.fromPoints(
          Offset(MediaQuery.of(context).size.width - 100, 60),
          Offset(MediaQuery.of(context).size.width - 20, 80),
        ),
        Size(MediaQuery.of(context).size.width, 40),
      ),
      items: [
        for (int i = 0; i < 8; i++)
          PopupMenuItem(
            value: i,
            child: Text('Filtro ${i + 1}'),
          ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedIndex = value;
          // Chamar onItemTapped na HomePage
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
      }
    });
  }
}*/
