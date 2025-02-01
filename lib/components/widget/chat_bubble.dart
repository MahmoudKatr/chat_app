import 'package:flutter/cupertino.dart';
import 'package:shop_app/model/message_model.dart';

import '../../constants/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 25,
          top: 25,
          bottom: 25,
          right: 25,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          color: AppColors.darkBlueGreen,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              32,
            ),
            topLeft: Radius.circular(
              32,
            ),
            bottomRight: Radius.circular(
              32,
            ),
          ),
        ),
        child: Text(
          message.message!,
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          left: 25,
          top: 25,
          bottom: 25,
          right: 25,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          color: AppColors.lightBlueGreen,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              32,
            ),
            topLeft: Radius.circular(
              32,
            ),
            bottomLeft: Radius.circular(
              32,
            ),
          ),
        ),
        child: Text(
          message.message!,
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
