import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                'Welcome Here',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Signup to continue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 40),
              // Full Name field
              TextField(
                controller: _fullNameController,
                style: const TextStyle(fontFamily: 'ClashDisplay'),
                // Automatically capitalizes the first letter of each name
                textCapitalization: TextCapitalization.words, 
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  hintStyle: TextStyle(
                    color: Colors.grey[400], 
                    fontFamily: 'ClashDisplay',
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
              const SizedBox(height: 16),
              // Email field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  // Using your specific light grey fill
                  fillColor: const Color.fromARGB(255, 245, 245, 245), 
                  
                  // 1. The default border (when not focused)
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  ),

                  // 2. The border when the user taps on it (Focus)
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFA867FF), width: 2.0), // Using your purple
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
                            const SizedBox(height: 16),
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
              const SizedBox(height: 32),
              // Sign up button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Sign up',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign-in');
                    },
                    child: Text(
                      'Sign in',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF00BCD4),
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
