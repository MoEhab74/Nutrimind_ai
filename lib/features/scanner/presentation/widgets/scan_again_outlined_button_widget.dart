import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ScanAgainOutlinedButton extends StatelessWidget {
  const ScanAgainOutlinedButton({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.pop(context),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 52.h),
        side: BorderSide(color: colorScheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedQrCode,
            color: colorScheme.onSurface,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Text(
            'Scan Again',
            style: AppTextStyles.semiBold16.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
