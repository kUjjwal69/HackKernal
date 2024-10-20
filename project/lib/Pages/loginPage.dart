
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project/Pages/registerPage.dart';
import 'package:project/routes.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async{
if (_formKey.currentState!.validate()) {
    Navigator.pushNamed(context,MyRoutes.HomeRoute);
  }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      // every widget can carry one widget in itslef
      // In case that widget wants to carry more widgets in himself 
      //he can choose childrens which allows him to do this
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,  
          child: Column(
            children: [
              // added an Image here
              Image.asset(
                "Assets/Images/undraw_Login_re_4vu2.png",
              fit:BoxFit.cover
              ),
              
              // Welcome text for users
              Text(
                "Welcome, You've been missed",
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
              validator: (value){
                if(value!.isEmpty){
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
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
                
                labelText: "Password",
                
              ),
              validator: (value){
                if(value!.isEmpty){
                    return "Password cannot be Empty";
                } 
                else if(value.length<6){
                    return "Password length should be at least 6";
                }
                return null;
              },
            ),
          
          
            // Login Button
          
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
            child: Text("Login",
           style:  TextStyle(
              fontWeight: FontWeight.bold,
               fontSize: 18,
              ),
              
              ),
              style: TextButton.styleFrom(minimumSize: Size(200, 40)),
              
            onPressed: () => moveToHome(context),
            ),
          
          
            // register Button
          
          
            SizedBox(
              height:
              35,
            ),
          
              Row(
                mainAxisAlignment:
                 MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                  style: TextStyle(
                    color: 
                  Theme.of(context).colorScheme.primary
                  )
                  ),
                  GestureDetector(
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
          
                  
                    child: Text("Register now", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    color: Theme.of(
                      context).colorScheme.primary
                      ),
                      ),
                  ),
                ],
              ),
            
            ],
          ),
        ),
      )
    );
  }
}