import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/functions/animated_snack_bar.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/widgets/top_app_bar.dart';
import 'package:nutrimind_ai/features/chat/data/models/message_model.dart';
import 'package:nutrimind_ai/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:nutrimind_ai/features/chat/presentation/widgets/messages_list_view_builder_widget.dart';
import 'package:nutrimind_ai/features/chat/presentation/widgets/suggesstion_chip_widget.dart';
import '../widgets/chat_header_widget.dart';
import '../widgets/chat_input_bar.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  late final Stream<dartz.Either<String, List<MessageModel>>> _messagesStream;

  final List<String> _suggestions = [
    'High Protein Meals',
    'Weight Loss',
    'Meal Plan',
    'Healthy Snacks',
  ];

  @override
  void initState() {
    super.initState();
    _messagesStream = context.read<ChatCubit>().chatRepository.getMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty) return;

    context.read<ChatCubit>().sendMessage(message: message);

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: const TopAppBar(title: 'Ai Chat'),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              // Expanded Widget ===> takes all the remaining space
              Expanded(
                // Chat Messages List ===> builder widget to render messages from firestore
                child: BlocConsumer<ChatCubit, ChatState>(
                  listener: (context, chatState) {
                    if (chatState is ChatSendMessageError) {
                      showAnimatedSnackbar(
                        context,
                        message: chatState.errorMessage,
                        type: AnimatedSnackBarType.error,
                      );
                    }
                  },
                  builder: (context, chatState) {
                    final isTyping = chatState is ChatSendMessageLoading;

                    return StreamBuilder<
                      dartz.Either<String, List<MessageModel>>
                    >(
                      stream: _messagesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return const Center(
                            child: Text("Something went wrong"),
                          );
                        }

                        return snapshot.data!.fold(
                          (failure) => Center(child: Text(failure)),
                          (messages) {
                            if (messages.isEmpty && !isTyping) {
                              return Column(
                                children: [
                                  const ChatHeaderWidget(),
                                  const Spacer(),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    alignment: WrapAlignment.center,
                                    children: _suggestions.map((suggestion) {
                                      return SuggestionChipWidget(
                                        label: suggestion,
                                        onTap: () {
                                          _messageController.text = suggestion;
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  const Spacer(),
                                ],
                              );
                            }
                            return MessagesListViewBuilderWidget(
                              messages: messages,
                              isTyping: isTyping,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 16.h),

              // Input Bar
              ChatInputBar(
                controller: _messageController,
                onSend: _sendMessage,
              ),

              // space to prevent Input Bar from covering the BottomNavBar
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: isKeyboardOpen ? 8.h : 80.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
