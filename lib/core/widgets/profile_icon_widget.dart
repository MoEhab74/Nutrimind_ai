import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class ProfileIconWidget extends StatelessWidget {
  const ProfileIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w),
      child: ClipOval(
        child: Image.asset(
          Assets.images.profile.path,
          width: 32.r,
          height: 32.r,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.account_circle, size: 32.r, color: AppColors.primary),
        ),
      ),
    );
  }
}
