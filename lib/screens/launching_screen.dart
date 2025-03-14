import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';

class LaunchingScreen extends StatelessWidget {
  const LaunchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsive positioning
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppColors.launchingPageGreen,
      body: Stack(
        children: [
          // Center logo
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: screenSize.width * 0.5, // Adjust size according to your image
              height: screenSize.width * 0.5, // Make it square and responsive
            ),
          ),
          
          // AI text at the bottom
          Positioned(
            bottom: screenSize.height * -0.13, // 5% from bottom
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/ai-text.png',
                width: screenSize.width * 0.30, // Adjust as needed
                height: screenSize.height * 0.30, // Small height for text logo
              ),
            ),
          ),
        ],
      ),
    );
  }
}