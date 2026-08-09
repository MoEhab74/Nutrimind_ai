import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/functions/animated_snack_bar.dart';
import 'package:nutrimind_ai/core/functions/validate_auth_fields.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_buttom.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/core/widgets/app_text_field_widget.dart';
import 'package:nutrimind_ai/core/widgets/default_app_bar.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_state.dart';
import 'package:nutrimind_ai/features/Auth/presentation/widgets/social_auth_buttom_widget.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signInWithEmailAndPassword(
        emailAddress: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      log('Form is invalid! try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const DefaultAppBar(title: 'Login', showBackButton: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppSizedBox(height: 24),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: colorScheme.primaryContainer,
                        width: 1.w,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(
                        Assets.images.loginImage.path,
                        height: 150.h,
                      ),
                    ),
                  ),
                ),
                const AppSizedBox(height: 32),
                Text(
                  'Welcome Back 🙌',
                  style: AppTextStyles.semiBold32.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const AppSizedBox(height: 8),
                Text(
                  'Login to your account to continue',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regular16.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                const AppSizedBox(height: 32),
                AppTextField(
                  label: 'Email',
                  hintText: 'name@example.com',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: validateEmail,
                ),
                const AppSizedBox(height: 16),
                AppTextField(
                  label: 'Password',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                  validator: validatePassword,
                ),
                const AppSizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.medium14.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const AppSizedBox(height: 24),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SignInSuccessState) {
                      showAnimatedSnackbar(
                        context,
                        message: 'Login Successfully',
                        type: AnimatedSnackBarType.success,
                      );
                      context.pushReplacementNamed(AppRoutes.home);
                    } else if (state is SignInFailureState) {
                      showAnimatedSnackbar(
                        context,
                        message: state.errorMessage,
                        type: AnimatedSnackBarType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is SignInLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : AppButton(
                            text: 'Login',
                            backgroundColor: colorScheme.primary,
                            textStyle: AppTextStyles.semiBold16.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                            onPressed: _handleLogin,
                          );
                  },
                ),
                const AppSizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: colorScheme.outlineVariant, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'OR CONTINUE WITH',
                        style: AppTextStyles.semiBold12.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: colorScheme.outlineVariant, thickness: 1),
                    ),
                  ],
                ),
                const AppSizedBox(height: 24),
                Row(
                  children: [
                    SocialAuthButton(
                      text: 'Google',
                      assetIcon: Assets.icons.google,
                      onPressed: () {},
                    ),
                    const AppSizedBox(width: 16),
                    SocialAuthButton(
                      text: 'Apple',
                      assetIcon: Assets.icons.apple,
                      onPressed: () {},
                    ),
                  ],
                ),
                const AppSizedBox(height: 32),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.regular16.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      children: [
                        const TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(
                          text: 'Sign Up',
                          style: AppTextStyles.medium14.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pop();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const AppSizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
