// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project/Pages/aboutPage.dart';
import 'package:project/Pages/homePage.dart';
import 'package:project/Pages/loginPage.dart';
import 'package:project/routes.dart';

void main()async{
  

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _HomeState();
}

class _HomeState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.LoginRoute,
      routes: {
        MyRoutes.LoginRoute:(context) => LoginPage(),
        MyRoutes.HomeRoute:(context) => HomePage(),
        MyRoutes.Aboutroute:(context) => AboutPage(),
      },
    );
  }
}