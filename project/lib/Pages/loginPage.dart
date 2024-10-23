// login_page.dart
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project/Pages/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _loginController.formKey,  // Use the formKey from the controller
          child: Column(
            children: [
              Image.asset(
                "Assets/Images/undraw_Login_re_4vu2.png",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.0, width: 15.0),
              TextFormField(
                controller: _loginController.emailController,  // Use the emailController from the controller
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email",
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be Empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _loginController.passwordController,  // Use the passwordController from the controller
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
              ),
              SizedBox(height: 20),
              _loginController.isLoading
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
                      onPressed: () => _loginController.moveToHome(context),  // Trigger login
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
