import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:prana_app/mainUi/chatscreen.dart';
import 'package:prana_app/mainUi/chattt.dart';
import 'package:prana_app/mainUi/chatwithprana.dart';
import 'package:prana_app/splashscreen/loadingscreen.dart';

import '../screens/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  final title = [
    'Real-Time Wellness in Action',
    'The Power of Your Voice',
    'Image Processing',
    'The Power of Your Voice',
  ];
  final subtitle = [
    'Step into the future of health assessments. Simply record a short video and let advanced facial analysis reveal precise insights into your well-being. Experience it now.....',
    'Your voice carries more than words—it holds clues about your health. Speak, record, and uncover patterns that reflect your physical and mental state. Try it.....',
    'Your voice carries more than and holds clues about your health. Speak, record, and uncover patterns that reflect your physical and mental state. Try it.....',
    'Step into the future of health assessments. Simply record a short video and let advanced facial analysis reveal precise insights into your well-being. Experience it now.....',
  ];
  final image = [
    'assets/images/01.png',
    'assets/images/02.png',
    'assets/images/03.png',
    'assets/images/04.png',
  ];
  final screens = [
    ChatScreen(initialMessage: 'Hi! How Can I Help You?'),
    Chatwithprana(),
    Chat(),
    ChatScreen(initialMessage: 'How can I Help You Today?'),

  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _openCamera() async {
    if (_isCameraInitialized) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              CameraScreen(cameraController: _cameraController),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(2, 8, 20, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Prana-Your Health Care",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(34, 34, 34, 1),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          // showDialog(context: context, builder: builder)
                        },
                        child: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Choose Your Age",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              InkWell(
                onTap: () {
                  _openCamera();
                },
                child: Container(
                  height: 193,
                  width: 326,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: const Color.fromRGBO(30, 30, 30, 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 95,
                        width: 206,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: const Color.fromRGBO(2, 8, 20, 1),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      Column(
                        children: const [
                          Text(
                            "Chat with Prana",
                            style: TextStyle(
                              fontSize: 18.25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                            style: TextStyle(
                              fontSize: 7.23,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Explore",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: List.generate(
                    title.length,
                        (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screens[index]));
                      },
                      child: Column(
                        children: [
                          exploreItem(
                            imagePath: image[index],
                            title: title[index],
                            subtitle: subtitle[index],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget exploreItem({
    required String imagePath,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.7),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CameraScreen extends StatelessWidget {
  final CameraController cameraController;

  const CameraScreen({super.key, required this.cameraController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera")),
      body: CameraPreview(cameraController),
    );
  }
}
