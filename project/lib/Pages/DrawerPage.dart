// drawerPage.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Drawerpage extends StatelessWidget {
  const Drawerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("Assets/Images/Ujjwal Kumar Photo-1.png"),
                    // Optionally, you can add a profile image
                    // backgroundImage: AssetImage('path/to/profile/image'),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "User Profile",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 10),
                // Buttons below the image
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  
                ),
              ],
            ),
          ),
          // Add more drawer items here
          ListTile(
            leading: Icon(Icons.person),
            title: Text("About App"),
            onTap: () {
              Navigator.pushNamed(context, '/about' );
            

            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              // Handle logout action
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
