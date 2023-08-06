import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  initstate() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nogari Chat'),
        actions: [
          IconButton(
            onPressed: () async {
              await _authentication.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.exit_to_app_outlined),
          )
        ],
      ),
      body: Center(
        child: Text('채팅 화면'),
      ),
    );
  }
}
