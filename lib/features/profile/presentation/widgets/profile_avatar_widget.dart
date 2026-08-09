import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                Assets.images.profile.path,
                width: 100.r,
                height: 100.r,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => CircleAvatar(
                  radius: 50.r,
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 50.r,
                    color: colorScheme.primary,
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
                backgroundColor: colorScheme.primary,
                child: Icon(
                  Icons.edit_outlined,
                  size: 16.w,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
