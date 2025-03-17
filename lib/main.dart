import 'package:ai_health_assistant/widgets/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_theme.dart';
import 'package:ai_health_assistant/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Natural Health AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

