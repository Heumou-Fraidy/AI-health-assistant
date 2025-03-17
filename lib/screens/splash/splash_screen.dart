import 'package:flutter/material.dart';
import 'package:ai_health_assistant/navigation/navigation_service.dart';
import 'package:ai_health_assistant/screens/onboarding/onboarding_screen.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';
// Add import for shared preferences to check if onboarding is completed
import 'package:ai_health_assistant/screens/auth/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Update the initState method to check if onboarding is completed
  @override
  void initState() {
    super.initState();

    // Setup fade animation
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    // Navigate after animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // TODO: Check if user has completed onboarding before
        // For now, always navigate to onboarding
        NavigationService.navigateWithReplacement(
          context, 
          const OnboardingScreen(),
          transition: TransitionType.fade,
        );
        
        // When you implement onboarding completion check, use this:
        // bool onboardingCompleted = await _checkOnboardingStatus();
        // if (onboardingCompleted) {
        //   NavigationService.navigateWithReplacement(
        //     context, 
        //     const SignInScreen(),
        //     transition: TransitionType.fade,
        //   );
        // } else {
        //   NavigationService.navigateWithReplacement(
        //     context, 
        //     const OnboardingScreen(),
        //     transition: TransitionType.fade,
        //   );
        // }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsive positioning
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: AppColors.primaryGreen,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: screenSize.width * 0.3,
                height: screenSize.width * 0.3,
                errorBuilder: (_, __, ___) => _placeholder(screenSize.width * 0.3),
              ),
              const SizedBox(height: 20),
              Text(
                "Natural Health AI",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(bottom: screenSize.height * 0.05),
                child: Image.asset(
                  'assets/images/aii.png',
                  width: screenSize.width * 0.4,
                  errorBuilder: (_, __, ___) => _textPlaceholder(),
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  // Placeholder widget if image is missing
  Widget _placeholder(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(size / 2),
    ),
    child: const Icon(Icons.healing, color: Colors.white, size: 48),
  );

  // Placeholder text if image is missing
  Widget _textPlaceholder() => const Text(
    "AI-powered health solutions",
    style: TextStyle(fontSize: 16, color: Colors.white70),
  );
}

