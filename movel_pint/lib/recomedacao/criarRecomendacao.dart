import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/Forum/Forum.dart'; // Importe a página ForumPage aqui

void main() {
  runApp(MaterialApp(
    home: RecommendationFormPage(),
  ));
}

class RecommendationFormPage extends StatefulWidget {
  @override
  _RecommendationFormPageState createState() => _RecommendationFormPageState();
}

class _RecommendationFormPageState extends State<RecommendationFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int _selectedIndex = 3;

  File? _image;
  String? _selectedSubtopic;
  double _rating = 0;

  final List<String> _subtopics = [
    'Restaurantes',
    'Hotéis',
    'Lazer',
    'Compras',
    'Serviços',
  ];

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Criar Nova Recomendação',
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
                          return 'Por favor, insira o título';
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
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o endereço';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Preço',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o preço';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Text('Classificação', style: TextStyle(fontSize: 16)),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
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
                              Navigator.pop(context); // Voltar para a página anterior
                            }
                          },
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String title = _titleController.text;
                              String description = _descriptionController.text;
                              String address = _addressController.text;
                              String price = _priceController.text;
                              String subtopic = _selectedSubtopic!;

                              // Exemplo de uso dos dados (pode ser enviado para um serviço, etc.)
                              print('Título: $title');
                              print('Descrição: $description');
                              print('Endereço: $address');
                              print('Preço: $price');
                              print('Classificação: $_rating');
                              print('Subtópico: $subtopic');

                              // Limpar formulário após envio
                              _titleController.clear();
                              _descriptionController.clear();
                              _addressController.clear();
                              _priceController.clear();
                              setState(() {
                                _image = null;
                                _selectedSubtopic = null;
                                _rating = 0;
                              });

                              // Pode adicionar lógica para enviar os dados para um serviço ou API aqui
                            }
                          },
                          child: const Text('Criar recomendação'),
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
    );
  }

  Future<bool?> _showCancelConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cancelar Recomendação'),
          content: Text('Tem certeza de que deseja cancelar a recomendação? Os dados não serão salvos.'),
          actions: <Widget>[
            TextButton(
              onPressed: ()
              {
                Navigator.of(context).pop(false); // Cancelar
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Continuar
              },
              child: Text('Continuar'),
            ),
          ],
        );
      },
    );
  }
}
