import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _userEnterMessage = '';

  final _contoller = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _contoller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  // message 전송
  _sendMessage() async {
    FocusScope.of(context).unfocus();

    await FirebaseFirestore.instance.collection('chat').add({
      'user': _user!.uid,
      'text': _userEnterMessage,
      'createdAt': Timestamp.now(),
    });

    _contoller.clear();
  }
}
