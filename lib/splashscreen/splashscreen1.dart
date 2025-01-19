import 'package:flutter/material.dart';
import 'dart:async';
import 'package:prana_app/screens/login.dart';
import 'package:prana_app/mainUi/home.dart';

import '../screens/login.dart';

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
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentStep < heading.length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        setState(() {
          currentStep++;
        });
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
    final widthh = MediaQuery.sizeOf(context).width;

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
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgressBar(0, widthh),
                  SizedBox(width: 10),
                  buildProgressBar(1, widthh),
                  SizedBox(width: 10),
                  buildProgressBar(2, widthh),
                  SizedBox(width: 10),
                  buildProgressBar(3, widthh),
                ],
              ),
              SizedBox(height: 150),
              SizedBox(
                  width: widthh / 1.5,
                  child: Image.asset(images[currentStep % images.length])),
              SizedBox(height: 100),
              buildTextForStep(0),
              buildTextForStep(1),
              buildTextForStep(2),
              buildTextForStep(3),
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
          duration: Duration(seconds: 2),
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
    bool isVisible = currentStep == step;

    return Visibility(
      visible: isVisible,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              heading[step],
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              subheading[step],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
