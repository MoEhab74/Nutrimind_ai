import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: AppTextStyles.regular16.copyWith(color: colorScheme.onSurface),
            decoration: InputDecoration(
              filled: true,
              fillColor: colorScheme.surfaceContainerLow,
              hintText: 'Ask anything...',
              hintStyle: AppTextStyles.regular16.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14.sp,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: colorScheme.surfaceContainerLow),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onSend,
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedSent,
                color: colorScheme.onPrimary,
                size: 22.w,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
