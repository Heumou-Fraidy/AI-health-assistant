import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is a placeholder for the home screen
    // You'll implement the actual home screen with AI features later
    return Scaffold(
      appBar: AppBar(
        title: const Text('Natural Health AI'),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.health_and_safety,
              size: 100,
              color: AppColors.primaryGreen,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Natural Health AI',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your AI-powered health assistant',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement AI consultation
              },
              icon: const Icon(Icons.mic),
              label: const Text('Start Voice Consultation'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

