import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final bool isUser;
  final DateTime createdAt;

  MessageModel({
    required this.message,
    required this.isUser,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'] ?? '',
      isUser: json['isUser'] ?? false,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUser': isUser,
      'createdAt': createdAt,
    };
  }
}
