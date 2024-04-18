
import 'package:flutter/material.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SOFTINSA Registration'),
        ),
        body: Material( 
          child: MyRegistrationForm(),
        ),
      ),
    );
  }
}

class MyRegistrationForm extends StatefulWidget {
  @override
  _MyRegistrationFormState createState() => _MyRegistrationFormState();
}
class _MyRegistrationFormState extends State<MyRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _confirmPassword; // Keeping the _confirmPassword variable

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty || value != _password) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) => _confirmPassword = value!, // Saving the value to _confirmPassword
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Here you can add your registration logic
                  // For example, you can print or use these variables
                  print('Email: $_email');
                  print('Password: $_password');
                  print('Confirm Password: $_confirmPassword'); // Utilizing _confirmPassword variable
                  // Add more logic here
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
<<<<<<< HEAD
=======
       bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
>>>>>>> eb754009382853329691717b54593552a7192ce6
    );
  }
}