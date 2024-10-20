// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
   final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async{
if (_formKey.currentState!.validate()) {
    Navigator.pushNamed(context, MyRoutes.HomeRoute);
  }
  }
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
       child: SingleChildScrollView(
         child: Form(
           child: Column(
            children: [
              Image.asset(
                "Assets/Images/undraw_Welcoming_re_x0qo.png",
              fit:BoxFit.cover
              ),
              
              Text(
                "Glad you joined us",
              style: TextStyle( 
                fontSize: 20,
                fontWeight: FontWeight.bold,
                
              ),
              
              ),
              SizedBox(
                height: 20.0,
                width: 15.0,
              ),
              
            // user name
           
            
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
              
            ),
            
           SizedBox(
                height: 10.0,
                
              ),
           
           
            // password
           
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
                
                labelText: " Password",
                
              ), validator: (value) {
                  if (value!.isEmpty) {
                    return "Password cannot be Empty";
                  } else if (value.length < 6) {
                    return "Password length should be at least 6";
                  }
                  return null;
                },
              ),
            
           
           
           
            SizedBox(
              height: 10,
            ),
              // confirm password
           
             
           
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Confirm Password",
                
                labelText: " Confirm Password",
                
              ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Confirm Password cannot be Empty";
                  } else if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              
            ),
           
            // Login Button
           
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
            child: Text("Register",
           style:  TextStyle(
              fontWeight: FontWeight.bold,
               fontSize: 18,
              ),
              
              ),
              style: TextButton.styleFrom(minimumSize: Size(200, 40)),
              
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.LoginRoute);
            },
            ),
           
           
                 
            
            ],
                 ),
         ),
       )
    );
  }
}