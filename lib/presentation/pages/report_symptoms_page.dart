import 'package:flutter/material.dart';

class ReportSymptomsPage extends StatefulWidget {
  const ReportSymptomsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReportSymptomsPageState createState() => _ReportSymptomsPageState();
}

class _ReportSymptomsPageState extends State<ReportSymptomsPage> {
  bool _fever = false;
  bool _cough = false;
  bool _tiredness = false;
  bool _difficultyBreathing = false;

  void _submitSymptoms() {
    List<String> symptoms = [];
    if (_fever) symptoms.add("Demam");
    if (_cough) symptoms.add("Batuk Kering");
    if (_tiredness) symptoms.add("Kelelahan");
    if (_difficultyBreathing) symptoms.add("Sesak Napas");

    String message = symptoms.isEmpty
        ? "Tidak ada gejala yang dilaporkan."
        : "Gejala yang dilaporkan: ${symptoms.join(', ')}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Laporan Gejala'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporkan Gejala COVID-19'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: const Text('Demam'),
              value: _fever,
              onChanged: (bool? value) {
                setState(() {
                  _fever = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Batuk Kering'),
              value: _cough,
              onChanged: (bool? value) {
                setState(() {
                  _cough = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Kelelahan'),
              value: _tiredness,
              onChanged: (bool? value) {
                setState(() {
                  _tiredness = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Sesak Napas'),
              value: _difficultyBreathing,
              onChanged: (bool? value) {
                setState(() {
                  _difficultyBreathing = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitSymptoms,
              child: const Text('Kirim Laporan Gejala'),
            ),
          ],
        ),
      ),
    );
  }
}
