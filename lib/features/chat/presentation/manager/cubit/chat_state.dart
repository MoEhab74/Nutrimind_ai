part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSendMessageLoading extends ChatState {}

final class ChatSendMessageSuccess extends ChatState {}

final class ChatSendMessageError extends ChatState {
  final String errorMessage;

  ChatSendMessageError({required this.errorMessage});
}

final class ChatGetMessagesLoading extends ChatState {}

final class ChatGetMessagesSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatGetMessagesSuccess({required this.messages});
}

final class ChatGetMessagesError extends ChatState {
  final String errorMessage;

  ChatGetMessagesError({required this.errorMessage});
}
