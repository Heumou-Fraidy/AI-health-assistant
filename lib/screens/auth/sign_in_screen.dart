import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';
import 'package:ai_health_assistant/widgets/auth/custom_text_field.dart';
import 'package:ai_health_assistant/widgets/auth/social_login_button.dart';
import 'package:ai_health_assistant/widgets/auth/auth_button.dart';
import 'package:ai_health_assistant/navigation/navigation_service.dart';
import 'package:ai_health_assistant/screens/auth/sign_up_screen.dart';
import 'package:ai_health_assistant/screens/home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    // TODO: Implement authentication logic here
    
    // Navigate to home screen after successful login
    NavigationService.navigateAndRemoveUntil(
      context,
      const HomeScreen(),
      transition: TransitionType.elegant,
    );
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light mint green
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                "Let's Sign In.!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Login to Your Account to Continue your Courses",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),

              // Email field
              CustomTextField(
                hintText: "Email",
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
              ),
              const SizedBox(height: 16),

              // Password field
              CustomTextField(
                hintText: "Password",
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 16),

              // Remember me and Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: AppColors.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Remember Me",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _handleForgotPassword,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign in button
              AuthButton(
                text: "Sign In",
                onPressed: _handleSignIn,
              ),
              const SizedBox(height: 24),

              // Or continue with
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Or Continue With",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                    imagePath: 'assets/images/google.png',
                    onPressed: () {
                      // TODO: Implement Google sign in
                    },
                  ),
                  const SizedBox(width: 16),
                  SocialLoginButton(
                    imagePath: 'assets/images/apple.png',
                    onPressed: () {
                      // TODO: Implement Apple sign in
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an Account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.navigateTo(
                        context,
                        const SignUpScreen(),
                        transition: TransitionType.slide,
                      );
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

