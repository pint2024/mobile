import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/utils/constants.dart';
import 'package:movel_pint/widgets/customAppBar.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';
import 'package:movel_pint/Forum/Forum.dart';

void main() {
  runApp(MaterialApp(home: EventFormPage()));
}

class EventFormPage extends StatefulWidget {
  @override
  _EventFormPageState createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  Uint8List? _imageData;
  String? _imageBase64;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedSubtopic;
  int _selectedIndex = 2;

  List<dynamic> _subtopics = [];

  @override
  void initState() {
    super.initState();
    _loadSubtopics();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _loadSubtopics() async {
    try {
      final response = await ApiService.listar("subtopico");
      if (response != null) {
        setState(() {
          _subtopics = response;
        });
      }
    } catch (e) {
      print("Error loading subtopics: $e");
    }
  }

  Future<void> _createEvento() async {
    if (_formKey.currentState!.validate()) {
      if (_imageData == null) {
        _showSnackbar("Por favor, selecione uma imagem.");
        return;
      }

      String name = _tituloController.text;
      String location = _enderecoController.text;
      String description = _descricaoController.text;
      String subtopic = _selectedSubtopic!;

      DateTime? dateTime;
      if (_selectedDate != null && _selectedTime != null) {
        dateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );
      }

      Map<String, dynamic> data = {
        'titulo': name,
        'descricao': description,
        'imagem': html.Blob([_imageData!]),
        'endereco': location,
        'data_evento': dateTime?.toIso8601String(),
        'utilizador': 1,  // ::::::::::::::::::::::::::::: substituir pelo id do utilizador logado :::::::::::::::::::::::::::::
        'subtopico': subtopic,
        'tipo': CONSTANTS.valores['EVENTO']?['ID'],
      };

      try {
        final response = await ApiService.criarFormData("conteudo", data: data, fileKey: "imagem");

        if (response != null) {
          _showSnackbar("Evento criado com sucesso, pode a ver na página dos Eventos");
        } else {
          print("Erro ao criar atividade: Resposta nula");
        }
      } catch (e) {
        print("Error creating atividade: $e");
      }
    }
  }

  Future<void> _getImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);

        reader.onLoadEnd.listen((e) {
          setState(() {
            _imageData = reader.result as Uint8List?;
            _imageBase64 = base64Encode(_imageData!);
          });
        });
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancelar Criação do Evento'),
          content: Text('Tem a certeza que quer cancelar a criação do evento? Os dados não serão guardados.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Continuar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ForumPage()), // Navega para a página ForumPage
                );
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Map<String, List<String>> organizarSubtopicos() {
    Map<String, List<String>> categorias = {};

    _subtopics.forEach((subtopico) {
      String topico = subtopico['subtopico_topico']['topico'];
      String area = subtopico['area'];

      if (!categorias.containsKey(topico)) {
        categorias[topico] = [];
      }

      categorias[topico]!.add(area);
    });

    return categorias;
  }

  List<DropdownMenuItem<String>> extrairAreas() {
    List<DropdownMenuItem<String>> items = [];
    _subtopics.forEach((subtopico) {
      final area = subtopico['area'];
      final id = subtopico['id'];

      items.add(DropdownMenuItem<String>(
        value: id.toString(),
        child: Text(area),
      ));
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Criar Novo Evento',
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
                    if (_imageData != null)
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Image.memory(
                          _imageData!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _getImage,
                      child: Text('Selecionar Imagem'),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _tituloController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do evento';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _enderecoController,
                      decoration: InputDecoration(
                        labelText: 'Local',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o local do evento';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _descricaoController,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedSubtopic,
                      decoration: InputDecoration(
                        labelText: 'Subtópico',
                        border: OutlineInputBorder(),
                      ),
                      items: extrairAreas(),
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
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: _selectedDate != null
                                ? TextEditingController(text: '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}')
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Dia',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (_selectedDate == null) {
                                return 'Por favor, selecione o dia do evento';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: _selectDate,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: _selectedTime != null
                                ? TextEditingController(text: '${_selectedTime!.hour}:${_selectedTime!.minute}')
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Hora',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (_selectedTime == null) {
                                return 'Por favor, selecione a hora do evento';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: _selectTime,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showCancelDialog();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(247, 245, 249, 1)),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => _createEvento(),
                          child: const Text('Criar evento'),
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
}
