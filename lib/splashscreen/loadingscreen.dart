import 'package:flutter/material.dart';
import 'dart:async';
import 'package:prana_app/splashscreen/splashscreen1.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  ValueNotifier<double> _progressNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progressNotifier.value >= 1.0) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Splashscreen1()),
        );
      } else {
        _progressNotifier.value += 0.1;
      }
    });
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
              "assets/images/Loading-screen.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: widthh,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Prana AI",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your Virtual Doctor.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 80),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthh * 0.14),
                    child: Container(
                      width: widthh,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(62, 62, 62, 1),
                      ),
                      child: ValueListenableBuilder<double>(
                        valueListenable: _progressNotifier,
                        builder: (context, progress, child) {
                          return LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(90, 245, 0, 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),
                  const Text(
                    "Loading....",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
