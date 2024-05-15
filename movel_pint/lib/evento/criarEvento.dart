/*import 'dart:io';

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

  Future<void> _launchMap(String location) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Dia',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: _selectDate,
                          controller: _selectedDate != null
                              ? TextEditingController(text: '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}')
                              : null,
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
                          decoration: InputDecoration(
                            labelText: 'Hora',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: _selectTime,
                          controller: _selectedTime != null
                              ? TextEditingController(text: '${_selectedTime!.hour}:${_selectedTime!.minute}')
                              : null,
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

                        // Navegar para a página de detalhes do evento
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsPage(
                              name: name,
                              location: location,
                              description: description,
                              dateTime: dateTime ?? DateTime.now(), // Defina um valor padrão se dateTime for nulo
                              image: _image,
                            ),
                          ),
                        );

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

class EventDetailsPage extends StatelessWidget {
  final String name;
  final String location;
  final String description;
  final DateTime dateTime;
  final File? image;

  const EventDetailsPage({
    required this.name,
    required this.location,
    required this.description,
    required this.dateTime,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Evento'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Image.file(
                image!,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            Text(
              'Nome: $name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Local: $location',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Descrição: $description',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Data e Hora: ${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
*/