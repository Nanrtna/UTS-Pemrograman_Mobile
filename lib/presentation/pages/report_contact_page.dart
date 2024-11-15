import 'package:flutter/material.dart';

class ReportContactPage extends StatefulWidget {
  const ReportContactPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReportContactPageState createState() => _ReportContactPageState();
}

class _ReportContactPageState extends State<ReportContactPage> {
  final TextEditingController _contactController = TextEditingController();

  void _submitContact() {
    String contactDetails = _contactController.text;
    String message = contactDetails.isEmpty
        ? "Tidak ada riwayat kontak yang dilaporkan."
        : "Riwayat kontak tercatat: $contactDetails";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Laporan Riwayat Kontak'),
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
        title: const Text('Laporkan Riwayat Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Masukkan detail riwayat kontak (jika ada):'),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                hintText: 'Misalnya: Berhubungan dengan pasien positif...',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitContact,
              child: const Text('Kirim Laporan Kontak'),
            ),
          ],
        ),
      ),
    );
  }
}
