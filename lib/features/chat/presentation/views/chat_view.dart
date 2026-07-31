import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/widgets/top_app_bar.dart';
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

  final List<String> _suggestions = [
    'High Protein Meals',
    'Weight Loss',
    'Meal Plan',
    'Healthy Snacks',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      // Logic to send the message to the AI
      log('Sending: ${_messageController.text}');
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: TopAppBar(title: 'Chat'),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              // Bot Details Header
              const ChatHeaderWidget(),
              const Spacer(),
              // Suggestions Chips
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                alignment: WrapAlignment.start,
                children: _suggestions.map((suggestion) {
                  return SuggestionChipWidget(
                    label: suggestion,
                    onTap: () {
                      _messageController.text = suggestion;
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 16.h),

              // Input Bar
              ChatInputBar(
                controller: _messageController,
                onSend: _sendMessage,
              ),

              // space to prevent Input Bar from covering the BottomNavBar  (and remove it when the keyboard is open)
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
