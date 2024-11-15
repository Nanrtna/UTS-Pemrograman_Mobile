import 'package:flutter/material.dart';
import '../../presentation/controllers/home_controller.dart';
import '../../api/firebase_api.dart';

class LoginPage extends StatefulWidget {
  final HomeController controller;

  const LoginPage(this.controller, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 250),
              const Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text.trim();
                  String password = _passwordController.text.trim();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logging in...'),
                      duration: Duration(seconds: 1),
                    ),
                  );

                  // Authenticate using FirebaseApi's signInWithEmail
                  var user =
                      await _firebaseApi.signInWithEmail(email, password);
                  if (user != null) {
                    // Show success notification
                    await _firebaseApi.subscribeToLoginSuccess();
                    await _firebaseApi.showNotification(
                        "Login Berhasil", "Selamat datang kembali!");

                    // Navigate to home page after successful login
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Login failed. Please check your credentials.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
