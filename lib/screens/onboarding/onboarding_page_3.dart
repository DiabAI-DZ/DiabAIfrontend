import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Illustration placeholder
              Container(
                margin: const EdgeInsets.only(bottom: 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/onboardingPageThreeImage.svg',
                        width: 400,
                        height: 400,
                        
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Title
              Text(
                'Smart Health Insights',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF451C1C),
                    ),
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'Turn raw numbers into clear charts. Get personalized alerts and easily share an accurate history with your doctor.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0XFFA86262),
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
