import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';

class TypingBubbleWidget extends StatefulWidget {
  const TypingBubbleWidget({super.key});

  @override
  State<TypingBubbleWidget> createState() => _TypingBubbleWidgetState();
}

class _TypingBubbleWidgetState extends State<TypingBubbleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.surfaceLow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
            bottomLeft: Radius.circular(4.r),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                final double delay = index * 0.2;
                final double value = ((_controller.value - delay) % 1.0).clamp(
                  0.0,
                  1.0,
                );
                final double bounce = (value < 0.5)
                    ? (value * 2)
                    : (2 - value * 2);

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Transform.translate(
                    offset: Offset(0, -bounce * 6.h),
                    child: CircleAvatar(
                      radius: 4.r,
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.4 + (bounce * 0.6),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
