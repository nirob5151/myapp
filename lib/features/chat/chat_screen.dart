
import 'package:flutter/material.dart';
import 'package:myapp/utils/routes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for chat conversations
    final List<Map<String, String>> conversations = [
      {
        'ownerName': 'John Doe',
        'lastMessage': 'Sure, it is available on Monday.',
        'time': '10:30 AM',
        'avatarUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
      },
      {
        'ownerName': 'Jane Smith',
        'lastMessage': 'Yes, the price is negotiable.',
        'time': 'Yesterday',
        'avatarUrl': 'https://randomuser.me/api/portraits/women/44.jpg',
      },
      {
        'ownerName': 'Peter Jones',
        'lastMessage': 'I can deliver it to your location.',
        'time': '2 days ago',
        'avatarUrl': 'https://randomuser.me/api/portraits/men/11.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final chat = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['avatarUrl']!),
            ),
            title: Text(chat['ownerName']!),
            subtitle: Text(chat['lastMessage']!),
            trailing: Text(chat['time']!),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.conversation, arguments: chat['ownerName']);
            },
          );
        },
      ),
    );
  }
}
