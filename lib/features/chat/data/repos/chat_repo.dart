import 'package:dartz/dartz.dart';
import 'package:nutrimind_ai/features/chat/data/models/message_model.dart';

abstract class ChatRepo {
  // Send message method ===> it will save the user message to firestore
  //then send it to gemini then get the response and save it to firestore
  Future<Either<String, void>> sendMessage({required String message});

  // Get messages method ===> it will get all messages from firestore ordered by date 
  Stream<Either<String, List<MessageModel>>> getMessages();
  // Clear messages method
  Future<Either<String, void>> clearMessages();
}
