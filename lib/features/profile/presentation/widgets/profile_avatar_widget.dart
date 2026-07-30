import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class ProfileAvatar extends StatelessWidget {
  // final String imageUrl;
  final VoidCallback onEditTap;

  const ProfileAvatar({
    super.key,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: const BoxDecoration(
              color: AppColors.surfaceLowest,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                Assets.images.profile.path,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColors.secondaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 50.w,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditTap,
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.edit_outlined,
                  size: 16.w,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
