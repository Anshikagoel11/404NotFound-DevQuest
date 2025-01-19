import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatwithprana extends StatefulWidget {
  const Chatwithprana({super.key});

  @override
  State<Chatwithprana> createState() => _ChatwithpranaState();
}

class _ChatwithpranaState extends State<Chatwithprana> {
  final TextEditingController _chatController = TextEditingController();
  List<Map<String, String>> messages = []; // Stores the user messages and API replies

  Future<void> _sendMessage(String userMessage) async {
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"user": userMessage}); // Add user message to the chat
    });

    try {
      final response = await http.post(
        Uri.parse('https://iitj-devquest.onrender.com/api/v1/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"text": userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Safely extract the deeply nested text field
        final apiReply = data["reply"]?["candidates"]?[0]?["content"]?["parts"]?[0]?["text"];

        if (apiReply != null) {
          setState(() {
            messages.add({"bot": apiReply}); // Add API reply to the chat
          });
        } else {
          setState(() {
            messages.add({"bot": "Sorry, I couldn't understand that."});
          });
        }
      } else {
        setState(() {
          messages.add({"bot": "Failed to get a response from the server."});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"bot": "An error occurred. Please try again."});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(2, 8, 20, 1),
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
                        child: const Icon(
                          Icons.keyboard_backspace_outlined,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Chat with Prana",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.more_vert_sharp,
                    size: 32,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message.containsKey("user");

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser
                            ? const Color.fromRGBO(90, 245, 0, 1)
                            : const Color.fromRGBO(50, 50, 50, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isUser ? message["user"]! : message["bot"]!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(30, 30, 30, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
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
                      final userMessage = _chatController.text.trim();
                      _chatController.clear();
                      _sendMessage(userMessage);
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
            ),
          ],
        ),
      ),
    );
  }
}
