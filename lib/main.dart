import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexa',
      theme: ThemeData(
        fontFamily: 'ClashDisplay',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00BCD4)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/sign-in': (context) => const SignInScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

