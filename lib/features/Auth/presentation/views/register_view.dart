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
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:nutrimind_ai/features/Auth/presentation/manager/cubit/auth_state.dart';
import 'package:nutrimind_ai/features/Auth/presentation/widgets/social_auth_buttom_widget.dart';
import 'package:nutrimind_ai/features/Auth/presentation/widgets/terms_conditions_check_box.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    if (_formKey.currentState!.validate()) {
      if (!_agreedToTerms) {
        showAnimatedSnackbar(
          context,
          message: 'Please agree to the Terms & Privacy Policy',
          type: AnimatedSnackBarType.error,
        );
        return;
      }
      // here we register the user
      context.read<AuthCubit>().signUpWithEmailAndPassword(
        fullName: _fullNameController.text.trim(),
        emailAddress: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create Account',
          style: AppTextStyles.semiBold20.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        Assets.images.registerImage.path,
                        height: 150.h,
                      ),
                    ),
                  ),
                ),
                const AppSizedBox(height: 32),
                Text(
                  'Create Your Account',
                  style: AppTextStyles.semiBold32.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const AppSizedBox(height: 8),
                Text(
                  'Let\'s start building healthier habits together.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regular16.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                const AppSizedBox(height: 32),
                AppTextField(
                  label: 'Full Name',
                  hintText: 'John Doe',
                  prefixIcon: Icons.person_outline,
                  controller: _fullNameController,
                ),
                const AppSizedBox(height: 20),
                AppTextField(
                  label: 'Email',
                  hintText: 'name@example.com',
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  validator: validateEmail,
                ),
                const AppSizedBox(height: 20),
                AppTextField(
                  label: 'Password',
                  hintText: '********',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: Icons.visibility_outlined,
                  isPassword: true,
                  controller: _passwordController,
                  validator: validatePassword,
                ),
                const AppSizedBox(height: 20),
                AppTextField(
                  label: 'Confirm Password',
                  hintText: '********',
                  prefixIcon: Icons.file_copy_outlined,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (value) =>
                      validateConfirmPassword(_passwordController.text, value),
                ),
                const AppSizedBox(height: 20),
                TermsAndConditionsCheckbox(
                  value: _agreedToTerms,
                  onChanged: (newValue) {
                    setState(() {
                      _agreedToTerms = newValue!;
                    });
                  },
                ),
                const AppSizedBox(height: 32),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SignUpFailureState) {
                      showAnimatedSnackbar(
                        context,
                        message: state.errorMessage,
                        type: AnimatedSnackBarType.error,
                      );
                    } else if (state is SignUpSuccessState) {
                      showAnimatedSnackbar(
                        context,
                        message: 'User registered successfully',
                        type: AnimatedSnackBarType.success,
                      );
                      log('User has been registered by Firebase Auth');
                      context.pushReplacement(AppRoutes.login);
                    }
                  },
                  builder: (context, state) {
                    return state is SignUpLoadingState
                        ? Center(
                            child: CircularProgressIndicator(
                              color: colorScheme.primary,
                            ),
                          )
                        : AppButton(
                            text: 'Create Account',
                            icon: Icon(
                              Icons.arrow_forward,
                              color: colorScheme.onPrimary,
                            ),
                            onPressed: _handleCreateAccount,
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
                        const TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign In',
                          style: AppTextStyles.medium14.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(AppRoutes.login);
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
