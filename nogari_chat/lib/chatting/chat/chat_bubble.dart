import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.isMyMessage});

  final String message;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 145,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
              color: isMyMessage ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight:
                    isMyMessage ? Radius.circular(0) : Radius.circular(12),
                bottomLeft:
                    isMyMessage ? Radius.circular(12) : Radius.circular(0),
              )),
          child: Text(
            message,
            style: TextStyle(color: isMyMessage ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
