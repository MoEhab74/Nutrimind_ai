import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/features/chat/data/models/message_model.dart';

class CustomChatBubbleWidget extends StatelessWidget {
  const CustomChatBubbleWidget({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final bool isUser = messageModel.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : AppColors.surfaceLow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(18.r),
            bottomLeft: Radius.circular(isUser ? 18.r : 4.r),
            bottomRight: Radius.circular(isUser ? 4.r : 18.r),
          ),
          boxShadow: isUser
              ? []
              : const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              messageModel.message,
              style: AppTextStyles.regular16.copyWith(
                color: isUser ? AppColors.onPrimary : AppColors.onSurface,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),

            Text(
              DateFormat('hh:mm a').format(
                DateTime.parse(messageModel.createdAt.toString()).toLocal(),
              ),
              style: AppTextStyles.semiBold12.copyWith(
                fontSize: 10.sp,
                color: isUser
                    ? AppColors.onPrimary.withValues(alpha: 0.7)
                    : AppColors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
