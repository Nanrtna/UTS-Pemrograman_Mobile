import 'package:geolocator/geolocator.dart';

// Fungsi untuk mendapatkan lokasi pengguna
Future<Position> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Mengecek apakah layanan lokasi di perangkat aktif
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Layanan lokasi tidak aktif');
  }

  // Mengecek apakah izin lokasi sudah diberikan
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Meminta izin jika belum diberikan
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Jika izin ditolak, tampilkan pesan error
      return Future.error('Izin lokasi ditolak');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Jika izin lokasi ditolak secara permanen, tampilkan pesan error
    return Future.error('Izin lokasi ditolak secara permanen, periksa pengaturan perangkat');
  }

  // Mengambil posisi pengguna dengan akurasi tinggi
  // ignore: deprecated_member_use
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
