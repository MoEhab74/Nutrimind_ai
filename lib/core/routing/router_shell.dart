import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nutrimind_ai/core/functions/animated_snack_bar.dart';
import 'package:nutrimind_ai/core/layout/bottom_nav_bar.dart';
import 'package:nutrimind_ai/core/routing/app_routes.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/scan_cubit/scan_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/choose_bottom_sheet_widget.dart';

class RouterShell extends StatelessWidget {
  const RouterShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    final int? navBarIndex = (currentIndex >= 0 && currentIndex <= 3)
        ? currentIndex
        : null;

    return BlocProvider(
      create: (context) => getIt<ScanCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
      body: BlocConsumer<ScanCubit, ScanState>(
        listener: (context, state) {
          if (state is ScanSuccess) {
            log('Food scanned successfully');
            final image = context.read<ScanCubit>().image;
            context.push(
              AppRoutes.scanResult,
              extra: {
                'foodModel': state.food,
                'image': image,
              },
            );
          } else if (state is ScanError) {
            showAnimatedSnackbar(
              context,
              message: state.errorMessage,
              type: AnimatedSnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          final isScanning = state is ScanLoading;

          return Stack(
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
                    navigationShell.goBranch(
                      index,
                      initialLocation: currentIndex == index,
                    );
                  },
                ),
              ),
              // Floating action button for Scanner
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                bottom: 24.h,
                child: GestureDetector(
                  onTap: isScanning
                      ? null
                      : () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => BlocProvider.value(
                              value: context.read<ScanCubit>(),
                              child: const ChooseBottomSheetWidget(),
                            ),
                          );
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    width:  56.w,
                    height:  56.w,
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
                      child: isScanning
                          ? SizedBox(
                              width: 22.w,
                              height: 22.w,
                              child: const CircularProgressIndicator(
                                color: AppColors.onPrimary,
                                strokeWidth: 2.5,
                              ),
                            )
                          : HugeIcon(
                              icon: HugeIcons.strokeRoundedAiScan,
                              size: 26.w,
                              color: AppColors.onPrimary,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      ),
    );
  }
  }

