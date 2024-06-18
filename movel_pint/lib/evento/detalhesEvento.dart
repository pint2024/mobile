import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: EventDetailsPage(),
  ));
}

class EventDetailsPage extends StatefulWidget {
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int _selectedIndex = 3;
  Map<String, dynamic>? _eventDetails;
  final int eventId = 1; // Definindo o ID do evento internamente

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchEventDetails(eventId); // Usando o ID definido internamente
  }

  Future<void> _fetchEventDetails(int eventId) async {
    try {
      final data = await ApiService.fetchData('conteudo/obter/$eventId'); // Alterando a rota
      print(data);
      if (data != null) {
        setState(() {
          _eventDetails = data?['data'];
        });
        print('Dados carregados com sucesso');
      } else {
        print('Dados não encontrados ou inválidos');
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  String _formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(parsedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _eventDetails != null
          ? _buildEventItem(_eventDetails)
          : Center(child: Text('Nenhum conteúdo disponível')),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic>? item) {
    print(item);
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDetailItemWithLabel(
            item?['titulo'] ?? 'Título não encontrado',
            isTitle: true,
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTag(item?['conteudo_tipo']['tipo']), // Tipo de conteúdo
              SizedBox(width: 8),
              _buildTag(item?['conteudo_subtopico']['area']), // Área do subtopico
              SizedBox(width: 8),
              _buildTag(item?['conteudo_subtopico']['subtopico_topico']['topico']), // Tópico
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: item?['imagem'] != null
                    ? (item!['imagem'].startsWith('http')
                        ? NetworkImage(item['imagem'])
                        : AssetImage('assets/Images/${item['imagem']}')) as ImageProvider
                    : AssetImage('assets/Images/jauzim.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildDetailItemWithLabel(
            item?['endereco'] ?? 'Endereço não encontrado',
          ),
          SizedBox(height: 16),
          _buildDetailItemLabel('Descrição'),
          _buildDetailItemWithLabel(
            item?['descricao'] ?? 'Descrição não encontrada',
            isDescription: true,
          ),
          SizedBox(height: 16),
          _buildDetailItemLabel('Data do Evento'),
          _buildDetailItemWithLabel(
            item?['data_evento'] != null
                ? _formatDateTime(item!['data_evento'])
                : 'Data do evento não disponível',
          ),
          SizedBox(height: 16),
          _buildDetailItemLabel('Criado por'),
          _buildDetailItemWithLabel(
            "${item?['conteudo_utilizador']['nome']} ${item?['conteudo_utilizador']['sobrenome']} em ${_formatDateTime(item?['data_criacao'])}",
            isDescription: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItemWithLabel(String value,
      {bool isTitle = false, bool isSubtopic = false, bool isDescription = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        value,
        style: TextStyle(
          fontSize: isTitle ? 18 : isSubtopic ? 14 : isDescription ? 12 : 14,
          fontWeight: isTitle || isSubtopic ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDetailItemLabel(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
