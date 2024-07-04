/*import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Adicionado
import 'registo.dart'; // Importe o arquivo registo.dart
import 'profile.dart'; // Importe o arquivo profile.dart

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
  bool _passwordVisible = false;
  bool _keepLoggedIn = false;

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
              child: SingleChildScrollView( // Adicionei o SingleChildScrollView aqui
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
                              'Login',
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
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.lock),
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
                        Row(
                          children: [
                            Checkbox(
                              value: _keepLoggedIn,
                              onChanged: (value) {
                                setState(() {
                                  _keepLoggedIn = value!;
                                });
                              },
                            ),
                            Text('Manter-me logado'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25, top: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.grey, fontSize: 14.0),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Esqueceu a senha?',
                                    style: TextStyle(
                                      color: Color.fromRGBO(57, 99, 156, 1.0),
                                      decoration: TextDecoration.underline,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1.5,
                                color: Color.fromRGBO(57, 99, 156, 1.0),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                            Text(
                              "OU", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromRGBO(57, 99, 156, 1.0),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1.5,
                                color: Color.fromRGBO(57, 99, 156, 1.0),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25), // Adicionei este SizedBox para espaçamento vertical
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Ionicons.logo_google,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _handleSignInWithGoogle(context);
                                },
                              ),
                            ),
                            SizedBox(width: 20), // Espaçamento entre os ícones
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Ionicons.logo_facebook,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _handleSignInWithFacebook(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: 'Não tens uma conta? ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Registar',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
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
      print('Keep me logged in: $_keepLoggedIn');
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
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Successful authentication, navigate to profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            userId: int.tryParse(userCredential.user!.uid) ?? 0,
          ),
        ),
      );
    } on PlatformException catch (error) {
      print('Erro ao autenticar com o Google: ${error.message}');
      // You can show a user-friendly error message here
    } catch (error) {
      print('Erro ao autenticar com o Google: $error');
      // You can show a user-friendly error message here
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
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        // Successful authentication, navigate to profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              userId: int.tryParse(userCredential.user!.uid) ?? 0,
            ),
          ),
        );
      } else if (result.status == LoginStatus.cancelled) {
        print('Autenticação com Facebook cancelada');
      } else {
        print('Erro ao autenticar com o Facebook: ${result.message}');
      }
    } on PlatformException catch (error) {
      print('Erro ao autenticar com o Facebook: ${error.message}');
    } catch (error) {
      print('Erro ao autenticar com o Facebook: $error');
    }
  }
}


  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sem conexão com a Internet'),
        content: Text('Por favor, verifique sua conexão com a Internet e tente novamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
*/