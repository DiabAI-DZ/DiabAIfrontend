import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/onboardingPageOneImage.svg',
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
                'Ditch the Paper Logbook',                
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFF451C1C),
                    ),
              ),
              const SizedBox(height: 16),
              // Description
              Text(
                'Simply snap a photo of your glucometer screen. Our AI instantly reads and saves your results no manual entry needed.',
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
