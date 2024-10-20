// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  // To convert responses

import 'package:project/Pages/registerPage.dart';
import 'package:project/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  bool isLoading = false;

  // The login function using REST API
  Future<void> login() async {
    final url = Uri.parse(" https://reqres.in/api/login");  

    setState(() {
      isLoading = true;  // Show loading spinner
    });

    // Make the POST request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    setState(() {
      isLoading = false;  // Hide loading spinner
    });

    if (response.statusCode == 200) {
      // Login successful
      var data = jsonDecode(response.body);  // Get response body

      if (data['success']) {
        Navigator.pushNamed(context, MyRoutes.HomeRoute);  // Navigate to home
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid username or password")),
        );
      }
    } else {
      // API call failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to login")),
      );
    }
  }

// Define controller to capture input
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // Trigger login if form is valid
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
     try {
        final response = await http.post(
          Uri.parse('https://yourapiurl.com/login'),
          body: jsonEncode({
            'username': usernameController.text,
            'password': passwordController.text,
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        // Check if the status code indicates success
        if (response.statusCode == 200) {
          // Parse the response body if necessary
          var data = jsonDecode(response.body);
          print("Login successful: $data");

          // Navigate to the home screen
          Navigator.pushNamed(context, MyRoutes.HomeRoute);
        } else {
          print("Failed to login: ${response.statusCode}");
          // Handle failed login (show error message)
        }
      } catch (error) {
        print("Error during API call: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "Assets/Images/undraw_Login_re_4vu2.png",
                fit: BoxFit.cover,
              ),
              
              SizedBox(height: 20.0, width: 15.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Username cannot be Empty";
                  }
                  return null;
                },
                onChanged: (value) {
                  username = value;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be Empty";
                  } else if (value.length < 6) {
                    return "Password length should be at least 6";
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()  // Show loading spinner
                  : ElevatedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: TextButton.styleFrom(minimumSize: Size(200, 40)),
                      onPressed: () => moveToHome(context),
                    ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to Logistics? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
