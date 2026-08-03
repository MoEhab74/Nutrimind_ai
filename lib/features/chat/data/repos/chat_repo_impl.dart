import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrimind_ai/core/api/api_consumer.dart';
import 'package:nutrimind_ai/core/api/api_endpoints.dart';
import 'package:nutrimind_ai/core/errors/server_exception.dart';
import 'package:nutrimind_ai/features/chat/data/models/message_model.dart';
import 'package:nutrimind_ai/features/chat/data/repos/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  ChatRepoImpl({
    required this._firestore,
    required this._firebaseAuth,
    required this._apiConsumer,
  });

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final ApiConsumer _apiConsumer;

  String get uid => _firebaseAuth.currentUser!.uid;

  // collection reference
  CollectionReference<Map<String, dynamic>> get messages =>
      _firestore.collection("users").doc(uid).collection("chats");

  @override
  Future<Either<String, void>> sendMessage({required String message}) async {
    try {
      // Save user message to firestore
      final createdAt = DateTime.now();
      final messageModel = MessageModel(
        message: message,
        isUser: true,
        createdAt: createdAt,
      );
      await messages.doc().set(messageModel.toJson());

      // Before sending to gemini he should know chat history so I'll get last 10 messages ordered by date
      final messagesQuerySnapshot = await messages
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();
      final chatHistory = messagesQuerySnapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList()
          .reversed
          .toList();

      // I'll build the prompt that consists of the following:
      // 1. The system prompt that describes the AI assistant
      // 2. The chat history
      // 3. The user message

      const systemPrompt =
          '''You are NutriMind AI, a helpful and friendly assistant specializing in nutrition, diet, and healthy food. Be concise and polite.
Respond in the language used by the user (Arabic, English, or Egyptian dialect). If the user mentions they speak Arabic or use Arabic, always reply in Arabic.''';

      final chatHistoryString = chatHistory
          .map((msg) => "${msg.isUser ? 'User' : 'Assistant'}: ${msg.message}")
          .join('\n');
      const prompt = '"""$systemPrompt"""';
      final String history = """
Chat History:
$chatHistoryString
""";

      // Send the prompt with message to gemini using apiConsumer because google_generative_ai deprecated
      // Prompt will be in system instructions

      final response = await _apiConsumer.post(
        "${ApiEndpoints.baseUrl}${ApiKeys.apiKey}",
        data: {
          "systemInstruction": {
            "parts": [
              {"text": prompt},
              {"text": history},
            ],
          },
          "contents": [
            {
              "parts": [
                {"text": message},
              ],
            },
          ],
          "generationConfig": {"temperature": 0.7, "maxOutputTokens": 500},
        },
      );

      // Get response from gemini
      final geminiResponse =
          response['candidates'][0]['content']['parts'][0]['text'];

      // Save response to firestore
      await messages.doc().set(
        MessageModel(
          message: geminiResponse,
          isUser: false,
          createdAt: DateTime.now(),
        ).toJson(),
      );

      // Return response
      return right(null);
    } on ServerException catch (e) {
      log('Server Exception in Chat Repo ===> ${e.errorModel.message}');
      return left(e.errorModel.message);
    } catch (error) {
      log('Something Went Wrong With Chat Repo ===> $error');
      return left("Failed to send message");
    }
  }

  // Convert it to stream to use the stream builder in the chat screen
  @override
  Stream<Either<String, List<MessageModel>>> getMessages() {
    return messages
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (snapshot) => Right(
            snapshot.docs
                .map((doc) => MessageModel.fromJson(doc.data()))
                .toList(),
          ),
        );
  }
}
