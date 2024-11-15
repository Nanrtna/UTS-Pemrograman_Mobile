import 'package:flutter/material.dart';
import 'package:uts/presentation/controllers/home_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(HomeController homeController, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isNotificationsEnabled = true;
  bool _isDarkModeEnabled = false;
  double _sliderValue = 0.5;
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Setting for notifications
          SwitchListTile(
            title: Text("Enable Notifications"),
            value: _isNotificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _isNotificationsEnabled = value;
              });
            },
          ),

          // Setting for Dark Mode
          SwitchListTile(
            title: Text("Enable Dark Mode"),
            value: _isDarkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _isDarkModeEnabled = value;
              });
            },
          ),

          // Setting for app language (dropdown)
          ListTile(
            title: Text("Language"),
            subtitle: Text(_selectedLanguage),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Tampilkan dialog untuk memilih bahasa
              _showLanguageDialog();
            },
          ),

          // Setting for volume control
          ListTile(
            title: Text("Volume"),
            subtitle: Text("Adjust volume level"),
            trailing: Slider(
              value: _sliderValue,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              // ignore: prefer_interpolation_to_compose_strings
              label: (_sliderValue * 100).round().toString() + "%",
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ),

          // Logout button
          ListTile(
            title: Text("Logout"),
            onTap: () {
              // Aksi logout
              // ignore: avoid_print
              print("Logging out...");
            },
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memilih bahasa dari dialog
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: DropdownButton<String>(
            value: _selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
              });
              Navigator.pop(context); // Menutup dialog setelah memilih
            },
            items: <String>['English', 'Indonesian', 'Spanish']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
