import 'package:flutter/material.dart';
import 'package:huma_care/constants/global_variable.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  // Recently chatted users (doctors & hospitals) – just names
  final List<Map<String, String>> recentChats = const [
    {"name": "City Hospital", "type": "hospital"},
    {"name": "Dr. Alice", "type": "doctor"},
    {"name": "Downtown Hospital", "type": "hospital"},
    {"name": "Dr. Bob", "type": "doctor"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF7165D6),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: recentChats.length,
        itemBuilder: (context, index) {
          final chat = recentChats[index];
          final icon = chat['type'] == 'hospital' ? Icons.local_hospital : Icons.person;

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: GlobalVariables.secondaryColor,
                child: Icon(icon, color: Colors.white),
              ),
              title: Text(
                chat['name']!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                // Navigate to chat screen (add route later)
              },
            ),
          );
        },
      ),
    );
  }
}

