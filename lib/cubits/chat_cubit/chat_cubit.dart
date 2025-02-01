import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/model/message_model.dart';

import 'chat_states.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  /// Send a message
  Future<void> sendMessage(String message, String email) async {
    try {
      await messages.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }

  /// Fetch and listen to messages
  void fetchMessages() {
    emit(ChatLoading());
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList =
          event.docs.map((doc) => MessageModel.fromJson(doc)).toList();
      emit(ChatSuccess(messageList));
    }, onError: (error) {
      emit(ChatError(error.toString()));
    });
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      final checkLogin = await SharedPreferences.getInstance();
      await checkLogin.setBool('isLoggedIn', false);
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }
}
