import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/functions/animated_snack_bar.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_state.dart';
import 'package:nutrimind_ai/features/profile/presentation/widgets/profile_tile_option.dart';

class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          showAnimatedSnackbar(
            context,
            message: 'Logout Successfully',
            type: AnimatedSnackBarType.success,
          );
          context.pushReplacementNamed(AppRoutes.register);
        }
      },
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        if (state is SignOutLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: ProfileTileOption(
            icon: Icons.logout_rounded,
            title: 'Logout',
            isDangerColor: colorScheme.error,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        );
      },
    );
  }
}

// Show Logout dialog

void _showLogoutDialog(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: colorScheme.errorContainer,
                child: Icon(
                  Icons.logout_rounded,
                  color: colorScheme.error,
                  size: 28.w,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                'Logout',
                style: AppTextStyles.semiBold20.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Are you sure you want to logout from your account?',
                textAlign: TextAlign.center,
                style: AppTextStyles.regular16.copyWith(
                  color: colorScheme.outline,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: BorderSide(color: colorScheme.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: colorScheme.onSurface,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        context.read<AuthCubit>().signOut();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: colorScheme.onError,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
