
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String initialMessage;

  const ChatScreen({super.key, required this.initialMessage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messages.add({
      'senderName': 'Prana',
      'message': widget.initialMessage,
      'isUser': false,
    });
  }

  void sendMessage() {
    String userMessage = _messageController.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        messages.add({
          'senderName': 'You',
          'message': userMessage,
          'isUser': true,
        });
        _listKey.currentState?.insertItem(messages.length - 1);
      });
      _messageController.clear();

      // Check if there's a predefined response
      String response = _getPredefinedResponse(userMessage);
      if (response.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            messages.add({
              'senderName': 'Prana',
              'message': response,
              'isUser': false,
            });
            _listKey.currentState?.insertItem(messages.length - 1);
          });
        });
      }

      Future.delayed(const Duration(milliseconds: 200), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  String _getPredefinedResponse(String userMessage) {
    if (userMessage.toLowerCase() == "hi" || userMessage.toLowerCase() == "hello") {
      return "Hello! How can I assist you today?";
    }
    if (userMessage.toLowerCase() == "how are you?") {
      return "I'm doing great, thank you for asking!";
    }
    if (userMessage.toLowerCase().contains("bye")) {
      return "Goodbye! Have a great day!";
    }
    if (userMessage.toLowerCase().contains("i love you")) {
      return "I Love You too...";
    }
    return "I am sorry, I dont know about this now";
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
                        "Prana Chat",
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
            Expanded(
              child: AnimatedList(
                key: _listKey,
                padding: const EdgeInsets.only(top: 20),
                initialItemCount: messages.length,
                controller: _scrollController,
                itemBuilder: (context, index, animation) {
                  final message = messages[index];
                  return _buildChatBubble(
                    context,
                    senderName: message['senderName'],
                    message: message['message'],
                    isUser: message['isUser'],
                    profileColor: message['isUser'] ? Colors.grey : Colors.green,
                    animation: animation,
                  );
                },
              ),
            ),
            buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(BuildContext context,
      {required String senderName,
        required String message,
        required bool isUser,
        required Color profileColor,
        required Animation<double> animation}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,

      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            senderName,
            style: TextStyle(
              color: Colors.grey[300],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUser)
                CircleAvatar(
                  radius: 16,
                  backgroundColor: profileColor,
                ),
              const SizedBox(width: 8),
              ScaleTransition(
                scale: animation,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.green : Colors.grey[700],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
                      bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isUser ? Colors.green.withOpacity(0.4) : Colors.grey.withOpacity(0.4),
                        offset: const Offset(4, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: FadeTransition(
                    opacity: animation,
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              if (isUser)
                CircleAvatar(
                  radius: 16,
                  backgroundColor: profileColor,
                ),
            ],
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.green,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
