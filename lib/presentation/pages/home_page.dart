import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_button.dart';
import 'report_symptoms_page.dart';
import 'report_contact_page.dart';
// ignore: unused_import
import 'location_service.dart';  // Import file location_service.dart

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({super.key, required this.controller, required String title, required userId}); 

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _currentPosition;
  List<Map<String, String>> _hospitals = [];

  @override
  void initState() {
    super.initState();
    _getLocationAndHospitals();
  }

  Future<void> _getLocationAndHospitals() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: avoid_print
      print("Layanan lokasi tidak aktif.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: avoid_print
        print("Izin lokasi ditolak.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: avoid_print
      print("Izin lokasi ditolak secara permanen.");
      return;
    }

    try {
      // ignore: deprecated_member_use
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });

      _hospitals = [
        {'name': 'Ciputra Hospital', 'vicinity': 'Jl. Citra Raya Boulevard Blok V00 no.8, Mekar Bakti, Panongan, Tangerang, Banten 15710'},
        {'name': 'RSIA Harapan Mulia', 'vicinity': 'Jl. Pemda Tigaraksa, Mata Gara, Tigaraksa, Tangerang, Banten 15720'},
        {'name': 'Bethsaida Hospital', 'vicinity': 'Jl. Boulevard Raya Gading Serpong Kav.29, Gading Serpong, Tangerang, Banten 15810'},
      ];
      setState(() {});
    } catch (e) {
      // ignore: avoid_print
      print(e);
      setState(() {
        _hospitals = [];
      });
    }
  }

  void _showCovidInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Info COVID-19'),
          content: Text(
            '''Gejala Umum COVID-19:
1. Demam, batuk kering, kelelahan.
2. Sesak napas, nyeri otot.
   
Protokol Kesehatan:
- Cuci tangan secara rutin.
- Gunakan masker dan jaga jarak.
- Hindari kerumunan.

Bila Anda merasa sakit, segera periksa ke fasilitas kesehatan terdekat.
Hubungi nomor darurat lokal atau rumah sakit terdekat.''',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
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
        title: Text('Sistem Respons Darurat COVID-19'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CustomButton(
              text: 'Informasi COVID-19',
              onPressed: () => _showCovidInfo(context),
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Laporkan Gejala COVID-19',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportSymptomsPage()),
                );
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Laporkan Riwayat Kontak',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportContactPage()),
                );
              },
            ),
            SizedBox(height: 20),
            _currentPosition == null
                ? Center(child: CircularProgressIndicator())
                : _hospitals.isEmpty
                    ? Center(child: Text('Tidak ada rumah sakit terdekat'))
                    : ListView.builder(
                        itemCount: _hospitals.length,
                        shrinkWrap: true, 
                        itemBuilder: (context, index) {
                          var hospital = _hospitals[index];
                          return ListTile(
                            title: Text(hospital['name']!),
                            subtitle: Text(hospital['vicinity']!),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(hospital['name']!),
                                    content: Text('Alamat: ${hospital['vicinity']}'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Tutup'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}
