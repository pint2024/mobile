import 'package:flutter/material.dart';
import 'package:movel_pint/perfil/profile.dart';
import 'package:movel_pint/widgets/bottom_navigation_bar.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String _name = "John Doe";
  String _birthday = "01/01/1990";
  String _phoneNumber = "123456789";
  String _instagramName = "john_doe";
  String _email = "john.doe@example.com";
  String _password = "**********";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your name",
              ),
              onChanged: (value) {
                _name = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Birthday:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your birthday",
              ),
              onChanged: (value) {
                _birthday = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Phone Number:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your phone number",
              ),
              onChanged: (value) {
                _phoneNumber = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Instagram Name:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your Instagram name",
              ),
              onChanged: (value) {
                _instagramName = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Email:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your email",
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            SizedBox(height: 20),
            Text(
              "Password:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your password",
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Cancel"),
                        content: Text("All changes will not be saved."),
                         actions: [
                  TextButton(
                    onPressed: () {
                      // Navigate to profile page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Text("Continue"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                ],
                      ),
                    );
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Save"),
                        content: Text("Are you sure you want to save?"),
                         actions: [
                  TextButton(
                    onPressed: () {
                      // Navigate to profile page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Text("Continue"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                ],
                      ),
                    );
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0, // Set the correct index
        onItemTapped: (int index) {
          // Implement logic to switch screens
        },
      ),
    );
  }
}
