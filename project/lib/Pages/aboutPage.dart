// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
            Navigator.pushNamed(context, '/');
        },
        icon:Icon(
          Icons.arrow_back),
         )
        
      ),
      body: Column(
        children: [
  

          // Align the image at the bottom center
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "Assets/Images/394950437_1385495148720912_4812952443226084640_n.webp",
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),

          // Some text below the image
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Text(
              'Hi, Thi side Ujjwal Kumar, I am a 2024 batch passout B.Tech student from Tecnocrats Institute of Technology in CSE branch, I have made this application only for HackKernal (Entry level flutter project), Hope you have liked my project',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
