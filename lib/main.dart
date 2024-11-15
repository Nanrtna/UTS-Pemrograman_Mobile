import 'package:flutter/material.dart';
// ignore: unused_import
import 'presentation/pages/home_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/controllers/home_controller.dart';
import 'core/navigation/navigation_service.dart';
import 'domain/usecases/navigate_to_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'api/firebase_api.dart'; // Import Firebase API

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize binding before async code

  // Memuat file .env untuk mendapatkan API key
  await dotenv.load();

  // Inisialisasi Firebase
  await Firebase.initializeApp();
  FirebaseApi(); // Initialize Firebase API for notifications and messaging

  // Jalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create instances of services and controllers
    final navigationService = NavigationService();
    final navigateToPageUseCase = NavigateToPageUseCase(navigationService);
    final homeController = HomeController(navigateToPageUseCase);

    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'Sistem Respons Darurat COVID-19',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Halaman pertama yang ditampilkan saat aplikasi dibuka
      routes: {
        '/login': (context) => LoginPage(homeController),
        '/home': (context) {
          var homeController2 = HomeController(navigateToPageUseCase); // Controller yang benar
          // Misalnya, userId bisa diambil dari penyimpanan lokal atau login session
          var userId = 'user123'; // Ganti sesuai dengan data nyata yang digunakan
          return HomePage(homeController: homeController, homeController2: homeController2, userId: userId);
        },
        '/profile': (context) => ProfilePage(homeController),
        '/settings': (context) => SettingsPage(homeController),
      },
    );
  }
}

// Halaman HomePage yang membutuhkan dua controller
class HomePage extends StatelessWidget {
  final HomeController homeController;
  final HomeController homeController2;
  final String userId;

  const HomePage({
    super.key,
    required this.homeController,
    required this.homeController2,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Text('Welcome, $userId!'), // Misalnya menampilkan userId
      ),
    );
  }
}
