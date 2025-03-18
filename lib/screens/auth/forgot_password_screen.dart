import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';
import 'package:ai_health_assistant/widgets/auth/auth_button.dart';
import 'package:ai_health_assistant/navigation/navigation_service.dart';
import 'package:ai_health_assistant/screens/auth/verification_code_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light mint green
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            
            const Text(
              "Select which contact details should we use to Reset Your Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            
            // Email option
            _buildContactOption(
              context: context,
              icon: Icons.email_outlined,
              title: "Via Email",
              value: "fraidyheumou@gmail.com",
              onTap: () => _handleContinue(context, "email"),
            ),
            
            const SizedBox(height: 16),
            
            // SMS option
            _buildContactOption(
              context: context,
              icon: Icons.sms_outlined,
              title: "Via SMS",
              value: "694951893",
              onTap: () => _handleContinue(context, "sms"),
            ),
            
            const Spacer(),
            
            // Continue button
            SizedBox(
              width: double.infinity,
              child: AuthButton(
                text: "Continue",
                onPressed: () => _handleContinue(context, "email"), // Default to email
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContactOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryGreen,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _handleContinue(BuildContext context, String method) {
    NavigationService.navigateTo(
      context,
      const VerificationCodeScreen(),
      transition: TransitionType.fade,
    );
  }
}

