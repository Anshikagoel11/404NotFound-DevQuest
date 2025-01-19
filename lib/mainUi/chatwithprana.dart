import 'package:flutter/material.dart';
import 'package:prana_app/mainui/chatscreen.dart';

class Chatwithprana extends StatefulWidget {
  const Chatwithprana({super.key});

  @override
  State<Chatwithprana> createState() => _ChatwithpranaState();
}

class _ChatwithpranaState extends State<Chatwithprana> {
  final TextEditingController _chatController = TextEditingController();
  List<String> predefinedMessages = [
    "How can I help you today? Please let me know any questions or problems you encounter",
    "Are you looking for something? I can help you find specific products or information",
    "Is there a particular preference you'd like to be aware of? I can make recommendations based on your tastes or needs",
    "Do you need a guide or tutorial to use this application? I can provide step by step help"
  ];

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(initialMessage: message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(2, 8, 20, 1),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.keyboard_backspace_outlined,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Chat with Prana",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_vert_sharp,
                    size: 32,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              width: 370,
              height: 234,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 30, 30, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(90, 245, 0, 1)),
                  ),
                  Text(
                    "Welcome, I'm Prana!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      "How are you! I am Savvy, your smart assistant. Have a specific question or assignment you would like to ask?",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Column(
                children: predefinedMessages.map((msg) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        _sendMessage(msg);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(50, 50, 50, 1)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          msg,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(30, 30, 30, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(50, 50, 50, 1),
                            hintText: "Ask me anything....",
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          if (_chatController.text.isNotEmpty) {
                            _sendMessage(_chatController.text);
                          }
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromRGBO(90, 245, 0, 1),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
