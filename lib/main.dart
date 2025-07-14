import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/category_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/medicine_provider.dart';
import 'package:medical_user_app/providers/services_provider.dart';
import 'package:medical_user_app/providers/theame_provider.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/splash_screen.dart';
import 'package:medical_user_app/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => MedicineProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider())

        // Add more providers here as needed
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: languageProvider.locale,
            theme: ThemeData.light().copyWith(
              textTheme:
                  ThemeData.light().textTheme.apply(fontFamily: 'Poppins'),
            ),
            darkTheme: ThemeData.dark().copyWith(
              textTheme:
                  ThemeData.dark().textTheme.apply(fontFamily: 'Poppins'),
            ),
            themeMode: themeProvider.themeMode,
            home: SplashScreen(),
            // home: NavbarScreen(),
          );
        },
      ),
    );
  }
}
