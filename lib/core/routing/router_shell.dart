import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/layout/bottom_nav_bar.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';

class RouterShell extends StatelessWidget {
  const RouterShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const int scannerBranchIndex = 2;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    // Map StatefulNavigationShell branch index (0: home, 1: chat, 2: scanner, 3: history, 4: profile)
    // to BottomNavBar index (0: home, 1: chat, 2: history, 3: profile)
    int? navBarIndex;
    if (currentIndex == 0) {
      navBarIndex = 0;
    } else if (currentIndex == 1) {
      navBarIndex = 1;
    } else if (currentIndex == 3) {
      navBarIndex = 2;
    } else if (currentIndex == 4) {
      navBarIndex = 3;
    } else {
      navBarIndex = null;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // 1. current screen
          navigationShell,
          // 2. bottom nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBar(
              currentIndex: navBarIndex,
              onTap: (index) {
                int targetBranch;
                switch (index) {
                  case 0:
                    targetBranch = 0; // Home
                    break;
                  case 1:
                    targetBranch = 1; // Chat
                    break;
                  case 2:
                    targetBranch = 3; // History
                    break;
                  case 3:
                    targetBranch = 4; // Profile
                    break;
                  default:
                    targetBranch = 0;
                }
                navigationShell.goBranch(
                  targetBranch,
                  initialLocation: currentIndex == targetBranch,
                );
              },
            ),
          ),
          // Floating action button for Scanner
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            bottom: currentIndex == 1 ? 40.h : 56.h,
            child: GestureDetector(
              onTap: () {
                navigationShell.goBranch(
                  scannerBranchIndex,
                  initialLocation: currentIndex == scannerBranchIndex,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: currentIndex == 1 ? 40.w : 56.w,
                height: currentIndex == 1 ? 40.w : 56.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedQrCode,
                    size: currentIndex == 1 ? 14.w : 26.w,
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
