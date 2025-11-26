
import 'package:flutter/material.dart';

class ConversationScreen extends StatelessWidget {
  final String ownerName;

  const ConversationScreen({super.key, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    // Dummy data for messages
    final List<Map<String, String>> messages = [
      {'sender': 'owner', 'message': 'Hi, how can I help you?'},
      {'sender': 'user', 'message': 'I am interested in renting the tractor.'},
      {'sender': 'owner', 'message': 'Sure, it is available on Monday.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(ownerName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isOwner = message['sender'] == 'owner';
                return Align(
                  alignment: isOwner ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isOwner ? Colors.grey[300] : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: isOwner ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Send message logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
