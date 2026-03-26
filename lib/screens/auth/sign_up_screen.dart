import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/auth_api.dart';
import '../../widgets/app_toast.dart';

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
  bool _isLoading = false;
  final RegExp _emailRegex =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');

  
  //defining a default value (for the android emulator)
  //for the real device we need to get the local ip of the host machine that is hosting the backend
  final AuthApi _authApi = AuthApi(
    baseUrl: const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8000',
    ),
  );

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

  bool _isValidEmail(String value) {
    return _emailRegex.hasMatch(value);
  }

  Future<void> _signUp() async {
    final name = _fullNameController.text;
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
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
    //starting the loading animation before the api call
    setState(() {
      _isLoading = true;
    });

    try {
      await _authApi.register(name: name, email: email, password: password);
      if (!mounted) return;
      AppToast.show(
        context,
        'Account created successfully. A verification email has been sent.',
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
                'Welcome Here',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF622E2E),
                    ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Signup to continue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFC88686),
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
                    color: const Color(0xFFC88686), 
                    fontFamily: 'ClashDisplay',
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
              const SizedBox(height: 16),
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
                    borderSide: const BorderSide(color: Color(0XFFEAC5C5), width: 2.0),                  ),

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
              const SizedBox(height: 32),
              // Sign up button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,// the method call happens here 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7181D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading//defining the shape of the loading animation using the ready assets
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFFFCF0F0),
                          ),
                        )
                      : Text(
                    'Sign up',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFCF0F0),
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
