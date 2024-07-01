import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCardAtividade extends StatefulWidget {
  final Map<String, dynamic> atividade;

  MyCardAtividade({required this.atividade});

  @override
  _MyCardAtividadeState createState() => _MyCardAtividadeState();
}

class _MyCardAtividadeState extends State<MyCardAtividade> {
  bool _isExpanded = false;

  String formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(parsedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adicionando margem
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Card(
          elevation: 3,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: widget.atividade['imagem'] != null
                        ? NetworkImage(widget.atividade['imagem'])
                        : AssetImage('assets/Images/logo2.png') as ImageProvider,
                  ),
                  title: Text(widget.atividade['titulo'] ?? 'Título da atividade'),
                  subtitle: Text(
                    '${widget.atividade['data_evento'] != null ? formatDateTime(widget.atividade['data_evento']) : ''} • ${widget.atividade['endereco'] ?? ''}',
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Container(
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.atividade['imagem'] != null
                            ? NetworkImage(widget.atividade['imagem'])
                            : AssetImage('assets/Images/logo2.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(widget.atividade['descricao'] ?? 'Um pouco do texto da atividade'),
                ),
                if (_isExpanded) ...[
                  Text('Endereço: ${widget.atividade['endereco'] ?? 'Não informado'}'),
                  SizedBox(height: 8),
                  Text('Data do Evento: ${widget.atividade['data_evento'] != null ? formatDateTime(widget.atividade['data_evento']) : 'Não informada'}'),
                  SizedBox(height: 8),
                  Text('Usuário: ${widget.atividade['utilizador'] ?? 'Desconhecido'}'),
                  SizedBox(height: 8),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildIconWithCount(Icons.photo_library_outlined, widget.atividade['album_conteudo']?.length.toString() ?? '0'),
                    SizedBox(width: 20),
                    _buildIconWithCount(Icons.comment_outlined, widget.atividade['comentario_conteudo']?.length.toString() ?? '0'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData iconData, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        SizedBox(width: 3),
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
