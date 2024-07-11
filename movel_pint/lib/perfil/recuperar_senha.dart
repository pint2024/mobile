import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:movel_pint/backend/api_service.dart'; // Certifique-se de importar sua classe ApiService

class RecuperarSenha extends StatefulWidget {
  @override
  _RecuperarSenhaState createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
        title: Text('Recuperar Senha'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _showCancelDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        color: const Color.fromRGBO(57, 99, 156, 1.0),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      bottom: 20,
                      top: 40,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recuperar Senha',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, informe seu e-mail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(57, 99, 156, 1.0)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _handlePasswordRecovery(context);
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Enviar',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePasswordRecovery(BuildContext context) async {
    final email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog(context);
      setState(() {
        _isLoading = false;
      });
    } else {
      final response = await ApiService.postData('autenticacao/forgot-password', {'email': email});

      setState(() {
        _isLoading = false;
      });

      if (response != null && response['success']) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Código de Verificação Enviado'),
              content: Text(response['data']),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response != null ? response['data'] : 'Erro desconhecido.')),
        );
      }
    }
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sem Conexão'),
          content: Text('Por favor, verifique sua conexão com a internet e tente novamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Continuar'),
              onPressed: () {
                Navigator.of(context).pop();
                _handlePasswordRecovery(context); // Retentativa do envio ao continuar
              },
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancelar Recuperação'),
          content: Text('Tem certeza de que deseja cancelar a recuperação de senha?'),
          actions: <Widget>[
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Fecha a tela de recuperação de senha
              },
            ),
          ],
        );
      },
    );
  }
}