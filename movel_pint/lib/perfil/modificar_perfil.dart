import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:movel_pint/backend/api_service.dart';
import 'package:movel_pint/widgets/customAppBar.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final int userId;
  final Map<String, dynamic> profileData;

  ProfileUpdateScreen({required this.userId, required this.profileData});

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _centerController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();

  Uint8List? _imageData;
  String? _imageBase64;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.profileData['nome'] ?? '';
    _lastNameController.text = widget.profileData['sobrenome'] ?? '';
    _centerController.text = widget.profileData['utilizador_centro']['centro'] ?? '';
    _linkedinController.text = widget.profileData['linkedin'] ?? '';
    _instagramController.text = widget.profileData['instagram'] ?? '';
    _facebookController.text = widget.profileData['facebook'] ?? '';
  }

  Future<void> _selectImage() async {
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

  Future<void> _atualizarPerfil() async {
    try {
      Map<String, dynamic> data = {
        'nome': _firstNameController.text,
        'sobrenome': _lastNameController.text,
        'utilizador_centro': {'centro': _centerController.text},
        'linkedin': _linkedinController.text,
        'instagram': _instagramController.text,
        'facebook': _facebookController.text,
      };

      await ApiService.atualizar('utilizador', widget.userId, data: data);

      if (_imageData != null) {
        await _enviarImagemPerfil();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil atualizado com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar perfil: $e')),
      );
    }
  }
//isso vai demorar
  Future<void> _enviarImagemPerfil() async {
    try {
      final response = await ApiService.sendProfilePic(
        'utilizador/atualizar/imagem/${widget.userId}',
        data: {'imagem': html.Blob([_imageData!])},
        fileKey: 'imagem',
      );

      if (response.statusCode == 200) {
        setState(() {
          _imageBase64 = base64Encode(_imageData!);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imagem de perfil atualizada com sucesso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar imagem de perfil: ${response.body}')),
        );
      }
    } catch (e) {
      print('Erro ao enviar imagem de perfil: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar imagem de perfil: $e')),
      );
    }
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
                'Atualizar Perfil',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
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
                    onPressed: _selectImage,
                    child: Text('Selecionar Imagem'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Sobrenome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _centerController,
                      decoration: InputDecoration(
                        labelText: 'Centro',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _linkedinController,
                      decoration: InputDecoration(
                        labelText: 'LinkedIn',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _instagramController,
                      decoration: InputDecoration(
                        labelText: 'Instagram',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _facebookController,
                      decoration: InputDecoration(
                        labelText: 'Facebook',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _atualizarPerfil,
                      child: Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
