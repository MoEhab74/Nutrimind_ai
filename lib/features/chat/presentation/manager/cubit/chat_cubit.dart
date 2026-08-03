import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/features/chat/data/models/message_model.dart';
import 'package:nutrimind_ai/features/chat/data/repos/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepository) : super(ChatInitial());
  final ChatRepo chatRepository;
  StreamSubscription? _messagesSubscription;

  Future<void> sendMessage({required String message}) async {
    emit(ChatSendMessageLoading());
    final result = await chatRepository.sendMessage(message: message);
    result.fold(
      (failure) => emit(ChatSendMessageError(errorMessage: failure)),
      (r) => emit(ChatSendMessageSuccess()),
    );
  }

  void getMessages() {
    emit(ChatGetMessagesLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription = chatRepository.getMessages().listen(
      (result) {
        result.fold(
          (failure) => emit(ChatGetMessagesError(errorMessage: failure)),
          (messages) => emit(ChatGetMessagesSuccess(messages: messages)),
        );
      },
      onError: (error) {
        emit(ChatGetMessagesError(errorMessage: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
    }
}
