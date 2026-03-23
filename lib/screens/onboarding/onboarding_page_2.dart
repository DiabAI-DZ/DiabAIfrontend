import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
                margin: const EdgeInsets.only(bottom: 100.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/onboardingPageTwoImage.svg',
                        width: 350,
                        height: 350,
                        
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Title
              Text(
                'Analyze Your Meals',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF451C1C),
                    ),
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'Take a picture of your plate to assess its impact. DiabIA helps you understand your food to better predict your blood sugar levels.',
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
