import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: EventFormPage(),
  ));
}

class EventFormPage extends StatefulWidget {
  @override
  _EventFormPageState createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _image;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Evento'),
        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
      ),
      body: Padding(
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
              child: ListView(
                shrinkWrap: true,
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
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Evento',
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
                    controller: _locationController,
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
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String name = _nameController.text;
                        String location = _locationController.text;
                        String description = _descriptionController.text;

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

                        // Exemplo de uso dos dados (pode ser enviado para um serviço, etc.)
                        print('Nome do Evento: $name');
                        print('Local: $location');
                        print('Descrição: $description');
                        if (dateTime != null) {
                          print('Data e Hora: $dateTime');
                        }

                        // Limpar formulário após envio
                        _nameController.clear();
                        _locationController.clear();
                        _descriptionController.clear();
                        setState(() {
                          _selectedDate = null;
                          _selectedTime = null;
                          _image = null;
                        });

                        // Pode adicionar lógica para enviar os dados para um serviço ou API aqui
                      }
                    },
                    child: const Text('Criar evento'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
