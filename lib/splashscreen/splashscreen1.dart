import 'package:flutter/material.dart';
import 'dart:async';
import 'package:prana_app/screens/login.dart';

class Splashscreen1 extends StatefulWidget {
  const Splashscreen1({super.key});

  @override
  State<Splashscreen1> createState() => _Splashscreen1State();
}

class _Splashscreen1State extends State<Splashscreen1> {
  int currentStep = 0;
  late Timer timer;

  final heading = [
    'Personalized Health Insights',
    'Secure Cloud Storage',
    'Easy-to-use',
    'Real-Time Feedback'
  ];
  final subheading = [
    'Get Tailored Health Evaluations based on facial and nail analysis',
    'Your health data is securely stored and processed.',
    'Intuitive design for hassle-free image and video upload.',
    'Instant guidance for capturing the best-quality img and videos.'
  ];
  final images = [
    "assets/images/sp12.png",
    "assets/images/sp13.png",
    "assets/images/sp14.png",
    "assets/images/sp12.png"
  ];

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentStep < heading.length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        timer.cancel();
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/sp1.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(heading.length, (index) {
                  return Row(
                    children: [
                      buildProgressBar(index, width),
                      if (index < heading.length - 1) const SizedBox(width: 10),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 150),
              SizedBox(
                width: width / 1.5,
                child: Image.asset(images[currentStep]),
              ),
              const SizedBox(height: 100),
              buildTextForStep(currentStep),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProgressBar(int step, double width) {
    double progressValue = (currentStep >= step) ? 1.0 : 0.0;

    return Container(
      width: width / 5,
      height: 8,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(62, 62, 62, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: progressValue),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextForStep(int step) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            heading[step],
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            subheading[step],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
