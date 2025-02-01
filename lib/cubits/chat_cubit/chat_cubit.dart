import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/model/message_model.dart';

import 'chat_states.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  /// إرسال رسالة نصية
  Future<void> sendMessage(String message, String email) async {
    try {
      await messages.add({
        'message': message,
        'image': null,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }

  /// إرسال صورة
  Future<void> sendImage(String email) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      try {
        String fileName =
            'chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        TaskSnapshot uploadTask =
            await FirebaseStorage.instance.ref(fileName).putFile(file);
        String imageUrl = await uploadTask.ref.getDownloadURL();

        await messages.add({
          'message': null,
          'image': imageUrl,
          'createdAt': DateTime.now(),
          'id': email,
        });
      } catch (error) {
        emit(ChatError(error.toString()));
      }
    }
  }

  /// تحميل الرسائل من Firebase
  void fetchMessages() {
    emit(ChatLoading());
    messages.orderBy('createdAt', descending: true).snapshots().listen((event) {
      List<MessageModel> messageList = event.docs.map((doc) {
        return MessageModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      emit(ChatSuccess(messageList));
    }, onError: (error) {
      emit(ChatError(error.toString()));
    });
  }

  /// تسجيل الخروج
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
