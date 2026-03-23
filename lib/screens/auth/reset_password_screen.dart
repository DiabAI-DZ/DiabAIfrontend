import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _otpController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                margin: const EdgeInsets.only(top: 25.0, bottom: 50.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 100,
                        height: 100,
                        
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Title
              Text(
                'Reset Password',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'You can change your password',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 40),
              // Password field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                // Applying Clash Display to the typed input text
                style: const TextStyle(fontFamily: 'ClashDisplay'), 
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey[400], fontFamily: 'ClashDisplay'),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 245, 245, 245),
                  
                  // 1. The default border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),

                  // 2. The border when focused (using your brand purple)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFA867FF), width: 2.0),
                  ),

                  contentPadding: const EdgeInsets.all(16),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password field
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                style: const TextStyle(fontFamily: 'ClashDisplay'),
                textInputAction: TextInputAction.done, // Closes keyboard on finish
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.grey[400], fontFamily: 'ClashDisplay'),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 245, 245, 245),
                  
                  // Default state
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),

                  // Focused state (using your purple)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFA867FF), width: 2.0),
                  ),

                  contentPadding: const EdgeInsets.all(16),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // OTP field
              TextField(
                controller: _otpController,
                // Using Clash Display to keep the numbers looking bold and modern
                style: const TextStyle(
                  fontFamily: 'ClashDisplay', 
                  fontWeight: FontWeight.w600,
                  letterSpacing: 8.0, // Adds space between the numbers for better readability
                ),
                textAlign: TextAlign.center, // Centers the OTP digits
                keyboardType: TextInputType.number,
                // Limits the input to 6 characters (common for OTP)
                maxLength: 6, 
                decoration: InputDecoration(
                  counterText: "", // Hides the character counter at the bottom
                  hintText: '000000',
                  hintStyle: TextStyle(
                    color: Colors.grey[400], 
                    fontFamily: 'ClashDisplay',
                    letterSpacing: 8.0,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 245, 245, 245),
                  
                  // Default border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),

                  // Focused border (your brand purple)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFA867FF), width: 2.0),
                  ),

                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),
              // Reset Password button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/sign-in');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
