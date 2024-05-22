import 'package:flutter/material.dart';
import 'package:movel_pint/backend/api_service.dart';

class DetalhesAtividade extends StatefulWidget {
  final int atividadeId;

  DetalhesAtividade({required this.atividadeId});

  @override
  _DetalhesAtividadeState createState() => _DetalhesAtividadeState();
}

class _DetalhesAtividadeState extends State<DetalhesAtividade> {
  Map<String, dynamic>? _atividadeDetalhes;

  @override
  void initState() {
    super.initState();
    _fetchAtividadeDetalhes();
  }

  Future<void> _fetchAtividadeDetalhes() async {
    try {
      final data = await ApiService.fetchData('http://localhost:8000/atividade/obter/${widget.atividadeId}');
      setState(() {
        _atividadeDetalhes = data['data'];
      });
      print('Detalhes da atividade carregados com sucesso');
    } catch (e) {
      print('Erro ao carregar detalhes da atividade: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Atividade'),
      ),
      body: SingleChildScrollView(
        child: _atividadeDetalhes == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_atividadeDetalhes!['conteudo_atividade'] != null)
                      for (var conteudo in _atividadeDetalhes!['conteudo_atividade'])
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network('http://10.0.2.2:8000/${conteudo['imagem']}'),
                            SizedBox(height: 10),
                            Text(
                              conteudo['titulo'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              conteudo['descricao'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Criado em: ${conteudo['data_criacao']}'),
                            SizedBox(height: 10),
                            Text('Endereço: ${conteudo['endereco']}'),
                            SizedBox(height: 10),
                            Text('Subtópico: ${conteudo['subtopico']}'),
                            SizedBox(height: 10),
                            Text('Espaço: ${conteudo['espaco'] ?? "Não informado"}'),
                            // Outros detalhes da atividade
                          ],
                        ),
                  ],
                ),
              ),
      ),
    );
  }
}
