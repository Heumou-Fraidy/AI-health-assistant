import 'package:flutter/material.dart';
import 'package:ai_health_assistant/screens/onboarding/pages/onboarding_page.dart';
import 'package:ai_health_assistant/navigation/navigation_service.dart';
import 'package:ai_health_assistant/screens/auth/sign_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      backgroundImage: 'assets/images/flower.png',
      title: 'WELCOME TO',
      subtitle: 'NATURAL HEALTH AI',
      description: 'Your AI-powered assistant for natural remedies',
    ),
    OnboardingPageData(
      backgroundImage: 'assets/images/fruits.png',
      title: 'IDENTIFY',
      subtitle: 'MEDICINAL PLANTS\nWITH A SINGLE PHOTO',
      description: 'Take a picture of any plant and learn about its medicinal properties',
    ),
    OnboardingPageData(
      backgroundImage: 'assets/images/doctor.png',
      title: 'AI CONSULTATION',
      subtitle: 'GET PERSONALIZED\nHEALTH ADVICE',
      description: 'Our AI analyzes your symptoms and suggests natural remedies',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    NavigationService.navigateAndRemoveUntil(
      context,
      const SignInScreen(),
      transition: TransitionType.fade,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                data: _pages[index],
                currentPage: _currentPage,
                totalPages: _pages.length,
                onNext: _nextPage,
                onSkip: _finishOnboarding,
              );
            },
          ),
        ],
      ),
    );
  }
}

