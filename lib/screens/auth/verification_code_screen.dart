import 'package:flutter/material.dart';
import 'package:ai_health_assistant/theme/app_colors.dart';
import 'package:ai_health_assistant/widgets/auth/auth_button.dart';
import 'package:ai_health_assistant/navigation/navigation_service.dart';
import 'package:ai_health_assistant/screens/auth/reset_password_screen.dart';
import 'dart:async';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<String> _code = ['', '', '', ''];
  int _currentIndex = 0;
  int _resendSeconds = 30;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }
  
  void _handleKeyPress(String value) {
    if (value == '<') {
      // Handle backspace
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
          _code[_currentIndex] = '';
        });
      }
    } else if (_currentIndex < _code.length) {
      // Handle number input
      setState(() {
        _code[_currentIndex] = value;
        if (_currentIndex < _code.length - 1) {
          _currentIndex++;
        }
      });
    }
  }
  
  void _handleVerify() {
    // Check if code is complete
    if (!_code.contains('')) {
      NavigationService.navigateTo(
        context,
        const ResetPasswordScreen(),
        transition: TransitionType.slide,
      );
    } else {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete verification code'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  void _handleResend() {
    if (_resendSeconds == 0) {
      // Reset the code
      setState(() {
        _code.fillRange(0, _code.length, '');
        _currentIndex = 0;
        _resendSeconds = 30;
      });
      _startResendTimer();
      
      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code resent'),
          backgroundColor: AppColors.primaryGreen,
        ),
      );
    }
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
            const SizedBox(height: 16),
            
            // Message
            const Text(
              "Code has been Send to (+237) *****1893",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            
            // Code input boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: _currentIndex == index
                          ? Border.all(color: AppColors.primaryGreen, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        _code[index].isEmpty ? '' : _code[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            
            // Resend code
            GestureDetector(
              onTap: _handleResend,
              child: RichText(
                text: TextSpan(
                  text: "Resend Code in ",
                  style: const TextStyle(color: Colors.black87),
                  children: [
                    TextSpan(
                      text: "${_resendSeconds}s",
                      style: TextStyle(
                        color: _resendSeconds > 0
                            ? Colors.orange
                            : AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Verify button
            SizedBox(
              width: double.infinity,
              child: AuthButton(
                text: "Verify",
                onPressed: _handleVerify,
              ),
            ),
            const SizedBox(height: 32),
            
            // Number pad
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildKeypadButton('1'),
                  _buildKeypadButton('2'),
                  _buildKeypadButton('3'),
                  _buildKeypadButton('4'),
                  _buildKeypadButton('5'),
                  _buildKeypadButton('6'),
                  _buildKeypadButton('7'),
                  _buildKeypadButton('8'),
                  _buildKeypadButton('9'),
                  _buildKeypadButton('*'),
                  _buildKeypadButton('0'),
                  _buildKeypadButton('<', isBackspace: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildKeypadButton(String value, {bool isBackspace = false}) {
    return InkWell(
      onTap: () => _handleKeyPress(value),
      borderRadius: BorderRadius.circular(12),
      child: Center(
        child: isBackspace
            ? const Icon(Icons.backspace_outlined, size: 24)
            : Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}

