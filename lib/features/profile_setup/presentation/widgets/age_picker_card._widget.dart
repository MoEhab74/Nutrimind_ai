import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class AgePickerCard extends StatelessWidget {
  final int age;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const AgePickerCard({
    super.key,
    required this.age,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.surfaceLow,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(icon: Icons.remove, onPressed: onDecrement),
          Container(
            width: 150.r,
            height: 150.r,
            decoration: const BoxDecoration(
              color: AppColors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$age',
                  style: AppTextStyles.bold40.copyWith(
                    color: AppColors.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Years young',
                  style: AppTextStyles.semiBold12.copyWith(
                    color: AppColors.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
          _buildActionButton(icon: Icons.add, onPressed: onIncrement),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: AppColors.surfaceContainer,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(icon, color: AppColors.onSurface, size: 24.w),
        ),
      ),
    );
  }
}
