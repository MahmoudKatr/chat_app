import 'package:shop_app/model/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatSuccess(this.messages);
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
