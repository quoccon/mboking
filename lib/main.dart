import 'package:flutter/material.dart';
import 'package:mbooking/welcome_screen.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light, // Ensure the brightness matches
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // Ensure the brightness matches
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      // Set the default theme mode to dark
      home: const WelcomeScreen(),
    );
  }
}
