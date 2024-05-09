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
        color: const Color.fromRGBO(57, 99, 156, 1.0), // Isso faz com que o fundo atrás da caixa seja azul
        child: Center(
          child: Transform.scale(
            scale: 0.9, // Isso diminui o tamanho do widget por um fator de 3
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
                    padding: EdgeInsets.only(bottom: 20.0, right: 10.0), // Adicione esta linha
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
                        borderRadius: BorderRadius.circular(10.0), // Adicione esta linha
                      ),
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adicione esta linha
                      ),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 10),
                  SwitchListTile(
                    title: Text('Lembrar-se do login'),
                    value: false, // Você pode substituir isso por uma variável que mantém o estado do switch
                    onChanged: (bool value) {
                      // Adicione aqui a lógica para lidar com a alteração do estado do switch
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity, // Isso faz com que o botão tenha a largura máxima disponível
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(57, 99, 156, 1.0)),
                      ),
                      onPressed: () {
                        // Adicione aqui a lógica para autenticar o usuário
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      _handleSignInWithGoogle(context);
                    },
                    child: Text('Login com Google'),
                  ),
                  Spacer(), // Adiciona um espaço flexível
                  // Botão para ir para a página de registro
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyRegistrationForm()), // Página de registro
                      );
                    },
                    child: Text(' Não tens uma conta? Registar'),
                  ),
                  SizedBox(height: 20), // Adiciona um espaço fixo no final
                ],
              ),
            ),
          ),
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
