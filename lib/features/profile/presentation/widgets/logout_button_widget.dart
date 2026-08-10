import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/functions/animated_snack_bar.dart';
import 'package:nutrimind_ai/core/functions/app_warning_dialog.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
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
              showAppWarningDialog(
                context,
                title: 'Logout',
                description:
                    'Are you sure you want to logout from your account?',
                buttonText: 'Logout',
                onConfirm: () {
                  context.read<AuthCubit>().signOut();
                },
              );
            },
          ),
        );
      },
    );
  }
}
