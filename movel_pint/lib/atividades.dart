import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/card.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

void main() {
  runApp(Atividade());
}

class Atividade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerAtividade(),
    );
  }
}

class VerAtividade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
                      'Título da Atividade',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list), 
                      onPressed: () {
                        // 
                      },
                    ),
                  ],
                ),
              ),
              AtividadeCard(
                imagemUrl:
                    'https://t4.ftcdn.net/jpg/03/84/55/29/360_F_384552930_zPoe9zgmCF7qgt8fqSedcyJ6C6Ye3dFs.jpg',
                titulo: 'Título da Atividade 1',
                criador: 'Nome do Criador 1',
                descricao: 'Descrição da Atividade 1',
                comentarios: ['Comentário 1', 'Comentário 2'],
                quantidadeAlbuns: 3,
              ),
              AtividadeCard(
                imagemUrl:
                    'https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/RE2wSVH_RE4dchU:VP1-539x349?resMode=sharp2&op_usm=1.5,0.65,15,0&qlt=90&fmt=png-alpha',
                titulo: 'Título da Atividade 2',
                criador: 'Nome do Criador 2',
                descricao: 'Descrição da Atividade 2',
                comentarios: ['Comentário 3', 'Comentário 4'],
                quantidadeAlbuns: 2,
              ),
              AtividadeCard(
                imagemUrl:
                    'https://img.freepik.com/fotos-gratis/arvore-solitaria_181624-46361.jpg?w=1060&t=st=171812141722~exp=1712142322~hmac=a0f37d64a060617c99ed647fab3b10e1b8e770402f9cdcfcbaaf92b879e20aa7',
                titulo: 'Título da Atividade 3',
                criador: 'Nome do Criador 3',
                descricao: 'Descrição da Atividade 3',
                comentarios: ['Comentário 5', 'Comentário 6'],
                quantidadeAlbuns: 1,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavigationBar(
            selectedIndex: 0, 
            onItemTapped: (index) {
              
            },
          ),
        ],
      ),
    );
  }
}

class AtividadeCard extends StatelessWidget {
  final String imagemUrl;
  final String titulo;
  final String criador;
  final String descricao;
  final List<String> comentarios;
  final int quantidadeAlbuns;

  AtividadeCard({
    required this.imagemUrl,
    required this.titulo,
    required this.criador,
    required this.descricao,
    required this.comentarios,
    required this.quantidadeAlbuns,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imagemUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              titulo,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Criado por: $criador'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(descricao),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Comentários (${comentarios.length})'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Quantidade de Álbuns: $quantidadeAlbuns'),
          ),
        ],
      ),
    );
  }
}
