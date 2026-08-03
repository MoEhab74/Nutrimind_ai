import 'package:flutter/material.dart';
import 'package:nutrimind_ai/features/chat/data/models/message_model.dart';
import 'package:nutrimind_ai/features/chat/presentation/widgets/custom_chat_bubble_widget.dart';
import 'package:nutrimind_ai/features/chat/presentation/widgets/typing_bubble_widget.dart';

class MessagesListViewBuilderWidget extends StatefulWidget {
  const MessagesListViewBuilderWidget({
    super.key,
    required this.messages,
    this.isTyping = false,
  });
  final List<MessageModel> messages;
  final bool isTyping;

  @override
  State<MessagesListViewBuilderWidget> createState() =>
      _MessagesListViewBuilderWidgetState();
}

class _MessagesListViewBuilderWidgetState
    extends State<MessagesListViewBuilderWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  @override
  void didUpdateWidget(covariant MessagesListViewBuilderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length != oldWidget.messages.length ||
        widget.isTyping != oldWidget.isTyping) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = widget.messages.length + (widget.isTyping ? 1 : 0);

    return ListView.builder(
      reverse: false,
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < widget.messages.length) {
          return CustomChatBubbleWidget(messageModel: widget.messages[index]);
        } else {
          return const TypingBubbleWidget();
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

