import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'registo.dart'; // Importe o arquivo registo.dart

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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    // Descartando os controladores quando não são mais necessários
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
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
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe seu e-mail';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe sua senha';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      SwitchListTile(
                        title: Text('Lembrar-se do login'),
                        value: _rememberMe,
                        onChanged: (bool value) {
                          setState(() {
                            _rememberMe = value;
                          });
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
                            if (_formKey.currentState!.validate()) {
                              _handleLogin(context);
                            }
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
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog(context);
    } else {
      // Lógica de login aqui
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
        // O código continua daqui
      } catch (error) {
        // Tratamento de erros (opcional)
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
