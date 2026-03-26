import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/auth_api.dart';
import '../../widgets/app_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String value) {
    return _emailRegex.hasMatch(value);
  }

  Future<void> _sendOtp() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      AppToast.show(
        context,
        'Please enter your email address.',
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

    setState(() {
      _isLoading = true;
    });

    try {
      await _authApi.sendResetOtp(email: email);
      if (!mounted) return;
      AppToast.show(
        context,
        'OTP sent. Check your email or Mailpit inbox.',
        type: AppToastType.success,
      );
      Navigator.pushNamed(
        context,
        '/reset-password',
        arguments: email,
      );
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
              // Logo
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
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF622E2E),
                    ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                "We'll email you an otp to reset your password",
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
                  // Using your specific light grey fill
                  fillColor: const Color(0xFFF5DEDE), 
                  
                  // 1. The default border (when not focused)
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0XFFEAC5C5), width: 2.0),
                  ),

                  // 2. The border when the user taps on it (Focus)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 136, 91, 91), width: 2.0), // Using your purple
                  ),

                  // 3. The border if there is an error
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),

                  contentPadding: const EdgeInsets.all(16),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),
              // Send OTP button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendOtp,
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
                          'Send otp',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFCF0F0),
                              ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // Back to sign in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You remembered your password? ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF854444),
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF9A1115),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
