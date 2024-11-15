import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? token;

  FirebaseApi() {
    _initializeLocalNotifications();
    _getToken();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(
            message.notification!.title!, message.notification!.body!);
      }
    });
  }

  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Fetch FCM token
  Future<void> _getToken() async {
    token = await _messaging.getToken();
    // ignore: avoid_print
    print('Token: $token');

    if (token != null) {
      await subscribeToLoginSuccess();
    } else {
      // ignore: avoid_print
      print('Token is null. Please wait for token to be generated.');
    }
  }

  // Show notification
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'login_success',
      'Login Notification',
      channelDescription: 'Notification for login',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  // Retrieve FCM token
  String? getToken() => token;

  // Subscribe to a topic
  Future<void> subscribeToLoginSuccess() async {
    if (token != null) {
      await _messaging.subscribeToTopic('login_success');
      // ignore: avoid_print
      print('Subscribed to login_success topic.');
    } else {
      // ignore: avoid_print
      print('Token is null. Please wait for token to be generated.');
    }
  }

  // Firebase Authentication: Sign in with Email and Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: avoid_print
      print("User signed in: ${userCredential.user?.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("Error during sign-in: $e");
      return null;
    }
  }

  // Firebase Authentication: Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    // ignore: avoid_print
    print("User signed out.");
  }

  // Firebase Authentication: Check current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
