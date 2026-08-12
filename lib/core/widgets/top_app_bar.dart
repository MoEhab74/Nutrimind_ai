import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key, required this.title, this.actionsWidget});
  final String title;
  final Widget? actionsWidget;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 180.w,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.images.logo.path, height: 24.h, width: 32.w),
            SizedBox(width: 4.w),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: AppTextStyles.semiBold20.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [actionsWidget ?? const SizedBox.shrink()],
    );
  }
}
