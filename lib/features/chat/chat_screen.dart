
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String ownerId;
  final String ownerName;

  const ChatScreen({super.key, required this.ownerId, required this.ownerName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final String _chatId;

  @override
  void initState() {
    super.initState();
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final uids = [currentUser.uid, widget.ownerId]..sort();
      _chatId = uids.join('_');
    } else {
      // Handle the case where the user is not authenticated
      // You might want to navigate them to the login screen
    }
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(_chatId)
            .collection('messages')
            .add({
          'text': _messageController.text,
          'senderId': currentUser.uid,
          'timestamp': Timestamp.now(),
        });
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.ownerName}'),
        backgroundColor: Colors.green[800],
      ),
      body: currentUser == null
          ? const Center(child: Text('Please log in to chat'))
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(_chatId)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No messages yet'));
                      }

                      final messages = snapshot.data!.docs;
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message['senderId'] == currentUser.uid;
                          return MessageBubble(
                            text: message['text'],
                            isMe: isMe,
                          );
                        },
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
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const MessageBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.green[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(text),
      ),
    );
  }
}
