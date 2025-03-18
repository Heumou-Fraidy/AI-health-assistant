import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';
import 'package:ai_health_assistant/widgets/auth/custom_text_field.dart';
import 'package:ai_health_assistant/widgets/auth/auth_button.dart';
import 'package:ai_health_assistant/navigation/navigation_service.dart';
import 'package:ai_health_assistant/screens/auth/sign_in_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  void _handleResetPassword() {
    // Validate passwords
    if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      _showError('Please enter both passwords');
      return;
    }
    
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showError('Passwords do not match');
      return;
    }
    
    // Show success and navigate back to sign in
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset successfully'),
        backgroundColor: AppColors.success,
      ),
    );
    
    // Navigate back to sign in
    Future.delayed(const Duration(seconds: 1), () {
      NavigationService.navigateAndRemoveUntil(
        context,
        const SignInScreen(),
        transition: TransitionType.fade,
      );
    });
  }
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
  
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
          "Reset Password",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
            
            const Text(
              "Create New Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your new password must be different from previously used passwords",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            
            // New password field
            CustomTextField(
              hintText: "New Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _newPasswordController,
            ),
            const SizedBox(height: 16),
            
            // Confirm password field
            CustomTextField(
              hintText: "Confirm Password",
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 32),
            
            // Reset button
            SizedBox(
              width: double.infinity,
              child: AuthButton(
                text: "Reset Password",
                onPressed: _handleResetPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

