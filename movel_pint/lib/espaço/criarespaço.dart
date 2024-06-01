import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/Forum/Forum.dart'; // Importe a página ForumPage aqui

void main() {
  runApp(MaterialApp(
    home: SpaceFormPage(),
  ));
}

class SpaceFormPage extends StatefulWidget {
  @override
  _SpaceFormPageState createState() => _SpaceFormPageState();
}

class _SpaceFormPageState extends State<SpaceFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  int _selectedIndex = 0;

  File? _image;
  String? _selectedSubtopic;

  final List<String> _subtopics = [
    'Tecnologia',
    'Ciência',
    'Artes',
    'Negócios',
    'Entretenimento',
    'Saúde',
    'Esportes',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    return WillPopScope(
      // Este WillPopScope é usado para detectar quando o usuário tenta voltar da página
      // e exibir o aviso de confirmação.
      onWillPop: () async {
        bool? confirm = await _showCancelConfirmationDialog(context);
        // Se o usuário confirmar, permita que a página seja fechada.
        return confirm ?? false;
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Criar Novo Espaço',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_image != null)
                        Image.file(
                          _image!,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ElevatedButton(
                        onPressed: _getImage,
                        child: Text('Selecionar Imagem'),
                      ),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Título',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o título do espaço';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Local',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o local do espaço';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedSubtopic,
                        decoration: InputDecoration(
                          labelText: 'Subtópico',
                          border: OutlineInputBorder(),
                        ),
                        items: _subtopics.map((String subtopic) {
                          return DropdownMenuItem<String>(
                            value: subtopic,
                            child: Text(subtopic),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSubtopic = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, selecione um subtópico';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              bool? confirm = await _showCancelConfirmationDialog(context);
                              if (confirm ?? false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ForumPage()),
                                );
                              }
                            },
                            child: Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String title = _titleController.text;
                                String description = _descriptionController.text;
                                String location = _locationController.text;
                                String subtopic = _selectedSubtopic!;

                                // Exemplo de uso dos dados (pode ser enviado para um serviço, etc.)
                                print('Título: $title');
                                print('Descrição: $description');
                                print('Local: $location');
                                print('Subtópico: $subtopic');

                                // Limpar formulário após envio
                                _titleController.clear();
                                _descriptionController.clear();
                                _locationController.clear();
                                setState(() {
                                  _image = null;
                                  _selectedSubtopic = null;
                                });

                                // Pode adicionar lógica para enviar os dados para um serviço ou API aqui
                              }
                            },
                            child: const Text('Criar espaço'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  Future<bool?> _showCancelConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cancelar Espaço'),
          content: Text('Tem certeza de que deseja cancelar o espaço? Os dados não serão salvos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Fecha o diálogo e retorna false para indicar que o usuário não deseja cancelar
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Fecha o diálogo e retorna true para indicar que o usuário deseja cancelar
                // e ir para a página ForumPage
                Navigator.of(context).pop(true);
              },
              child: Text('Continuar'),
            ),
          ],
        );
      },
    );
  }
}
