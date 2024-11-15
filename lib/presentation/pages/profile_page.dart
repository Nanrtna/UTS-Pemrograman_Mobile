import 'package:flutter/material.dart';
import 'package:uts/presentation/controllers/home_controller.dart';

class ProfilePage extends StatelessWidget {
  final String name = "Nandita Ratana";  
  final String email = "nanditarttna@student.esaunggul.ac.id"; 
  // ignore: non_constant_identifier_names
  final String NIM = "20220801033";  
  final String imageUrl = "https://alphacoders.com/xiao-(genshin-impact)-pfp";

  const ProfilePage(HomeController homeController, {super.key});  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // ignore: avoid_print
              print("Edit profile");
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,  
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),  
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              NIM,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print("Logout clicked");
                },
                // ignore: sort_child_properties_last
                child: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
