// login_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/routes.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Function to perform the login API call
  Future<void> login(BuildContext context) async {
    final url = Uri.parse("https://reqres.in/api/login");

    // Display loading spinner (if needed)
    isLoading = true;

    // Make the POST request
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );

    isLoading = false; // Hide loading spinner

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['token'] != null) {
        // Navigate to home page on successful login
        Navigator.pushNamed(context, MyRoutes.HomeRoute);
      } else {
        // Show invalid login message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid email or password")),
        );
      }
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // API call failed, show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: Unable to login")),
      );
    }
  }

  // Function to handle form validation and login
  Future<void> moveToHome(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await login(context);
      } catch (error) {
        print("Error during API call: $error");
      }
    }
  }
}
