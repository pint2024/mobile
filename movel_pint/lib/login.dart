import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movel_pint/registo.dart'; // Importe o arquivo registro.dart

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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 99, 156, 1.0),
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Adicione aqui a lógica para autenticar o usuário
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                _handleSignInWithGoogle(context);
              },
              child: Text('Login com Google'),
            ),
            SizedBox(height: 20),
            // Botão para ir para a página de registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfileApp()), // Página de registro
                );
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignInWithGoogle(BuildContext context) async {
    try {
      // Configure o GoogleSignIn
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      // Autentique o usuário com o Google
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        // O usuário está autenticado com o Google, você pode prosseguir com o login
        // ou armazenar as credenciais do usuário, conforme necessário.
        print('Usuário autenticado com sucesso: ${googleUser.email}');
      } else {
        // O usuário cancelou o processo de login com o Google
        print('Falha ao autenticar com o Google');
      }
    } catch (error) {
      print('Erro ao autenticar com o Google: $error');
    }
  }
}
