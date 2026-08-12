import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';

class ProfileStatCard extends StatelessWidget {
  final String? tag;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? tagColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget? extraWidget;

  const ProfileStatCard({
    super.key,
    this.tag,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.tagColor,
    this.titleColor,
    this.subtitleColor,
    this.extraWidget,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = backgroundColor ?? colorScheme.surfaceContainerLow;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor ?? colorScheme.primary, size: 22.w),
              if (tag != null)
                Text(
                  tag!,
                  style: AppTextStyles.semiBold12.copyWith(
                    color: tagColor ?? colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: AppTextStyles.semiBold20.copyWith(
                  color: titleColor ?? colorScheme.onSurface,
                ),
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (subtitle.isNotEmpty)
                Flexible(
                  child: Text(
                    subtitle,
                    style: AppTextStyles.medium14.copyWith(
                      color: subtitleColor ?? colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              extraWidget ?? const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}