import 'package:flutter/material.dart';
// ignore: unused_import
import 'home_page.dart';  // Pastikan halaman ini diimpor
// ignore: unused_import
import 'info_page.dart';  // Pastikan halaman ini diimpor

class BasePage extends StatefulWidget {
  final Widget child;

  const BasePage({super.key, required this.child});

  @override
  // ignore: library_private_types_in_public_api
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 Info Center'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Navigasi ke InfoPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('COVID-19 Tracker'),
              accountEmail: Text('info@covid19app.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.health_and_safety, color: Colors.blue),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigasi ke HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(title: 'Home', userId: null)),
                );
              },
            ),
            // Anda dapat menambahkan daftar halaman lain sesuai kebutuhan di sini
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigasi ke halaman settings
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Prevention'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PreventionPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: widget.child, // Menampilkan halaman konten utama yang dikirimkan
    );
  }
}

// Halaman InfoPage
class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("COVID-19 Information")),
      body: Center(
        child: Text(
          "Information about COVID-19",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Pastikan HomePage memiliki konstruktor yang sesuai
class HomePage extends StatelessWidget {
  final String title;
  final String? userId;

  // Konstruktor untuk menerima parameter title dan userId
  const HomePage({super.key, required this.title, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text("Welcome to the Home Page", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// Halaman-halaman lainnya (SettingsPage, PreventionPage, etc.)

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(
        child: Text("Settings Page", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class PreventionPage extends StatelessWidget {
  const PreventionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prevention")),
      body: Center(
        child: Text("Prevention Tips", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
