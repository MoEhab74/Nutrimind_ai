import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.title});
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 120.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          children: [
            Image.asset(Assets.images.logo.path, height: 24.h, width: 32.w),
            SizedBox(width: 4.w),
            Text(
              title,
              style: AppTextStyles.semiBold20.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: ClipOval(
            child: Image.asset(
              Assets.images.profile.path,
              width: 32.w,
              height: 32.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.account_circle,
                size: 32.w,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
