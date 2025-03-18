import 'package:flutter/material.dart';
import 'package:ai_health_assistant/widgets/animated_text.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';

class OnboardingPageData {
  final String backgroundImage;
  final String title;
  final String subtitle;
  final String description;

  OnboardingPageData({
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage({
    Key? key,
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            data.backgroundImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.primaryGreen.withOpacity(0.9),
              child: const Center(
                child: Icon(Icons.healing, size: 64, color: Colors.white),
              ),
            ),
          ),
          
           /* Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ), */
          
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skip Button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, right: 10.0),
                    child: TextButton(
                      onPressed: onSkip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const Spacer(flex: 3),
                
                // Title with animation
                AnimatedText(
                  text: data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  delay: const Duration(milliseconds: 200),
                ),
                
                const SizedBox(height: 8.0),
                
                // Subtitle with animation
                AnimatedText(
                  text: data.subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  delay: const Duration(milliseconds: 300),
                ),
                
                const SizedBox(height: 12.0),
                
                // Description with animation
                AnimatedText(
                  text: data.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                  ),
                  delay: const Duration(milliseconds: 400),
                ),
                
                const Spacer(),
                
                // Navigation controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    children: [
                      // Page indicators
                      Row(
                        children: List.generate(
                          totalPages,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            width: 20.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? AppColors.accentGreen
                                  : Colors.white.withOpacity(0.90),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Next button
                      FloatingActionButton(
                        onPressed: onNext,
                        backgroundColor: AppColors.accentGreen,
                        child: const Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

