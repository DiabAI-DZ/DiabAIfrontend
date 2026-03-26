import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/auth_api.dart';
import '../../widgets/app_toast.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _otpController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  final RegExp _emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

  final AuthApi _authApi = AuthApi(
    baseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8000',
    ),
  );

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String && _emailController.text.isEmpty) {
      _emailController.text = args;
    }
  }

  bool _isValidEmail(String value) {
    return _emailRegex.hasMatch(value);
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    final otp = _otpController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || otp.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      AppToast.show(
        context,
        'All fields are required.',
        type: AppToastType.error,
      );
      return;
    }

    if (!_isValidEmail(email)) {
      AppToast.show(
        context,
        'Please enter a valid email address.',
        type: AppToastType.error,
      );
      return;
    }

    if (otp.length != 6) {
      AppToast.show(
        context,
        'OTP must be 6 digits.',
        type: AppToastType.error,
      );
      return;
    }

    if (password != confirmPassword) {
      AppToast.show(
        context,
        'Passwords do not match.',
        type: AppToastType.error,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authApi.resetPassword(
        email: email,
        otp: otp,
        password: password,
        passwordConfirmation: confirmPassword,
      );
      if (!mounted) return;
      AppToast.show(
        context,
        'Password reset successful. Please sign in again.',
        type: AppToastType.success,
      );
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/sign-in');
    } on AuthApiException catch (e) {
      if (!mounted) return;
      AppToast.show(
        context,
        e.message.isEmpty ? e.toString() : e.message,
        type: AppToastType.error,
      );
    } catch (e) {
      if (!mounted) return;
      AppToast.show(
        context,
        'Unexpected error: ${e.toString()}',
        type: AppToastType.error,
      );
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
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
                      color: const Color(0XFF622E2E),
                    ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'You can change your password',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFC88686),
                    ),
              ),
              const SizedBox(height: 40),
              // Email field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: const Color(0xFFC88686)),
                  filled: true,
                  fillColor: const Color(0xFFF5DEDE),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0XFFEAC5C5), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 136, 91, 91), width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Password field
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                // Applying Clash Display to the typed input text
                style: const TextStyle(fontFamily: 'ClashDisplay'), 
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: const Color(0xFFC88686), fontFamily: 'ClashDisplay'),
                  filled: true,
                  fillColor: const Color(0xFFF5DEDE), 
                  
                  // 1. The default border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0XFFEAC5C5), width: 2.0),                  ),

                  // 2. The border when focused (using your brand purple)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 136, 91, 91), width: 2.0),
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
                  hintStyle: TextStyle(color: const Color(0xFFC88686), fontFamily: 'ClashDisplay'),
                  filled: true,
                  fillColor: const Color(0xFFF5DEDE), 
                  
                  // Default state
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0XFFEAC5C5), width: 2.0),                  ),

                  // Focused state (using your purple)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 136, 91, 91), width: 2.0),                  ),

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
                    color: const Color(0xFFC88686), 
                    fontFamily: 'ClashDisplay',
                    letterSpacing: 8.0,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5DEDE), 
                  
                  // Default border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0XFFEAC5C5), width: 2.0),                  ),

                  // Focused border (your brand purple)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 136, 91, 91), width: 2.0),
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
                  onPressed: _isLoading ? null : _resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7181D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFFFCF0F0),
                          ),
                        )
                      : Text(
                          'Reset Password',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCF0F0),
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
