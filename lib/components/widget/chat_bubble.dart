import 'package:flutter/material.dart';
import 'package:shop_app/model/message_model.dart';
import '../../constants/constants.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.darkBlueGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        child: message.image != null
            ? Image.network(message.image!)
            : Text(
                message.message!,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  final MessageModel message;
  const ChatBubbleForFriend({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.lightBlueGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        child: message.image != null
            ? Image.network(message.image!)
            : Text(
                message.message!,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
