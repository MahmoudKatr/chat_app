import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/features/authentications/login_screen.dart';
import 'package:shop_app/features/chat/chat_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Show splash for 3 seconds

    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const ChatScreen() : const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your splash screen background color
      body: Center(
        child: Image.asset(
          "assets/Chat_App_Splash_Screen.jpg",
          width: 350,
          height: 600,
        ), // Add your logo
      ),
    );
  }
}
