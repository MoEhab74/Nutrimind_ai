import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/features/profile/presentation/widgets/dark_mode_switch_widget.dart';
import 'package:nutrimind_ai/features/profile/presentation/widgets/notification_switch_widget.dart';
import 'package:nutrimind_ai/features/profile/presentation/widgets/profile_avatar_widget.dart';
import 'package:nutrimind_ai/features/profile/presentation/widgets/profile_state_card.dart';
import 'package:nutrimind_ai/features/profile/presentation/widgets/profile_tile_option.dart';
import 'package:nutrimind_ai/gen/assets.gen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? fullName;
  String? email;
  String? goal;
  String? weight;
  String? height;
  String? targetWeight;

  User? user = getIt<FirebaseAuth>().currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  // get user fullName and email from firestore method
  void getUserData() async {
    final userDocSnapshot = await getIt<FirebaseFirestore>()
        .collection('users')
        .doc(user?.uid)
        .get();
    if (!mounted) return;
    final data = userDocSnapshot.data();
    if (data != null) {
      setState(() {
        fullName = data['fullName'] as String?;
        email = data['emailAddress'] as String?;
        goal = data['goal'] as String?;
        weight = data['weight']?.toString();
        height = data['height']?.toString();
        targetWeight = data['targetWeight']?.toString();
      });
    }
  }

  String _formatGoal(String? goal) {
    if (goal == null) return 'Weight Loss';
    switch (goal) {
      case 'maintainWeight':
        return 'Maintain Weight';
      case 'loseWeight':
        return 'Weight Loss';
      case 'gainMuscle':
        return 'Muscle Gain';
      default:
        return goal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                "Profile",
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 8.h,
          ).copyWith(bottom: 64.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. الصورة والمعلومات الشخصية
              ProfileAvatar(onEditTap: () {}),
              SizedBox(height: 12.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      fullName ?? 'Boda',
                      style: AppTextStyles.semiBold28.copyWith(
                        color: AppColors.onBackground,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      email ?? '[EMAIL_ADDRESS]',
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.outline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Statistics Grid
              Builder(
                builder: (context) {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 1.15,
                    children: [
                      ProfileStatCard(
                        tag: 'GOAL',
                        title: _formatGoal(goal),
                        subtitle: 'Target: ${targetWeight ?? '72'}kg',
                        icon: Icons.track_changes_outlined,
                        backgroundColor: AppColors.secondaryContainer,
                      ),
                      ProfileStatCard(
                        tag: 'BMI INDEX',
                        title: '23.5',
                        subtitle: '',
                        icon: Icons.crop_square_outlined,
                        extraWidget: Row(
                          children: [
                            // for progress bar (BMI) the max value of BMI is 30
                            // create a progress bar for BMI
                            SizedBox(
                              width: 50.w,
                              height: 8.h,
                              child: LinearProgressIndicator(
                                value: 23.5 / 30,
                                color: AppColors.primary,
                                backgroundColor: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Normal',
                              style: AppTextStyles.semiBold12.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ProfileStatCard(
                        title: weight != null ? '$weight kg' : '78 kg',
                        subtitle: 'Weight',
                        icon: Icons.hourglass_empty_rounded,
                      ),
                      ProfileStatCard(
                        title: height != null ? '$height cm' : '182 cm',
                        subtitle: 'Height',
                        icon: Icons.square_foot_outlined,
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 24.h),
              Text(
                'ACCOUNT SETTINGS',
                style: AppTextStyles.semiBold12.copyWith(
                  color: AppColors.outline,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 12.h),

              // Account Settings Group
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    ProfileTileOption(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                      trailing: const NotificationsSwitch(),
                    ),
                    ProfileTileOption(
                      icon: Icons.nightlight_round_outlined,
                      title: 'Dark Mode',
                      trailing: const DarkModeSwitch(),
                    ),
                    ProfileTileOption(
                      icon: Icons.translate_outlined,
                      title: 'Language',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'English',
                            style: AppTextStyles.medium14.copyWith(
                              color: AppColors.outline,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14.w,
                            color: AppColors.outline,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),
              // Support & Logout Group
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLow,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    ProfileTileOption(
                      icon: Icons.help_outline_rounded,
                      title: 'Help Center',
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14.w,
                        color: AppColors.outline,
                      ),
                      onTap: () {},
                    ),
                    ProfileTileOption(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      isDangerColor: AppColors.error,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
