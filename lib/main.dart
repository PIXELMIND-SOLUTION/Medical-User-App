import 'package:flutter/material.dart';
import 'package:medical_user_app/view/login_screen.dart';
import 'package:medical_user_app/view/scanned_medicine_screen.dart';
import 'package:medical_user_app/view/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rental App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScannedMedicineScreen(),
    );
  }
}