import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Chat",
        style: AppTextStyles.semiBold20.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
