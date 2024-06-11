import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'registo.dart'; // Importe o arquivo registro.dart

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Image.asset(
                  'assets/Images/logo.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(57, 99, 156, 1.0),
        child: Center(
          child: Transform.scale(
            scale: 0.9,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
                    child: Text(
                      'Login in to your Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 10),
                  SwitchListTile(
                    title: Text('Lembrar-se do login'),
                    value: false,
                    onChanged: (bool value) {
                      // Adicione aqui a lógica para lidar com a alteração do estado do switch
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(57, 99, 156, 1.0)),
                      ),
                      onPressed: () {
                        _handleLogin(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Transform.scale(
                          scale: 1.5, // Ajuste o tamanho conforme necessário
                          child: Icon(
                            Ionicons.logo_google,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          _handleSignInWithGoogle(context);
                        },
                      ),
                      SizedBox(width: 20), // Espaçamento entre os ícones
                      IconButton(
                        icon: Transform.scale(
                          scale: 1.5, // Ajuste o tamanho conforme necessário
                          child: Icon(
                            Ionicons.logo_facebook,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        onPressed: () {
                          _handleSignInWithFacebook(context);
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(' Não tens uma conta? Registar'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog(context);
    } else {
      // Adicione aqui a lógica para autenticar o usuário
      print('Usuário autenticado com sucesso');
    }
  }

  Future<void> _handleSignInWithGoogle(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog(context);
    } else {
      try {
        GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
        GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        if (googleUser != null) {
          print('Usuário autenticado com sucesso: ${googleUser.email}');
        } else {
          print('Falha ao autenticar com o Google');
        }
      } catch (error) {
        print('Erro ao autenticar com o Google: $error');
      }
    }
  }

  Future<void> _handleSignInWithFacebook(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog(context);
    } else {
      try {
        final LoginResult result = await FacebookAuth.instance.login();
        if (result.status == LoginStatus.success) {
          final AccessToken accessToken = result.accessToken!;
          print('Usuário autenticado com sucesso no Facebook');
        } else {
          print('Falha ao autenticar com o Facebook: ${result.status}');
        }
      } catch (error) {
        print('Erro ao autenticar com o Facebook: $error');
      }
    }
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sem Conexão com a Internet'),
          content: Text('Por favor, ligue-se à internet para continuar.'),
          actions: [
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
  }
}
