import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? message;
  final String? image;
  final String id;
  final DateTime createdAt;

  MessageModel(
      {this.message, this.image, required this.id, required this.createdAt});

  /// تحويل البيانات من JSON إلى كائن Dart
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      image: json['image'],
      id: json['id'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  /// تحويل كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'image': image,
      'id': id,
      'createdAt': createdAt,
    };
  }
}
