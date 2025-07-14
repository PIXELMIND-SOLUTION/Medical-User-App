
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/view/main_layout.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/on_boarding_screen.dart';
import 'package:medical_user_app/view/home_screen.dart'; // Your home screen
import 'package:medical_user_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

Future<void> _initializeApp() async {
  await Future.delayed(const Duration(seconds: 2));

  final token = await SharedPreferencesHelper.getToken();
  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$token");

  if (mounted) {
    _navigateToNextScreen(token.toString());
  }
}


void _navigateToNextScreen(String token) {
  Widget nextScreen;

  print("lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll$token");

  if (token != "null" && token.trim().isNotEmpty) {
    // Valid token → go to MainLayout
    nextScreen = const MainLayout();
  } else {
    // Invalid token → go to Onboarding
    nextScreen = const OnboardingScreen();
  }



  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 74),
              // App Logo
              Container(
                width: 238,
                height: 238,
                child: Center(
                  child: Image.asset(
                    'assets/login.png',
                    width: 238,
                    height: 238,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Welcome Text
              const AppText(
                'welcome',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Slogan Text
              const AppText(
                'slogan',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 80),
              // Loading Indicator
              const CircularProgressIndicator(
                color: Color(0xFF5931DD),
                strokeWidth: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}