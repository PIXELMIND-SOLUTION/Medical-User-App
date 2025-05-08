import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_user_app/view/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set timer to navigate after 4 seconds
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
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
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Slogan Text
              const Text(
                'Your Health Is Our Priority',
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