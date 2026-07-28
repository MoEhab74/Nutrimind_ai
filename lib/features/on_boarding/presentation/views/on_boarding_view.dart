import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/features/on_boarding/data/on_boarding_model.dart';
import 'package:nutrimind_ai/features/on_boarding/presentation/widgets/on_boarding_buttom_widget.dart';
import 'package:nutrimind_ai/features/on_boarding/presentation/widgets/on_boarding_page_widget.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key, required this.onFinish});

  final VoidCallback onFinish;

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final List<BoardingModel> pages = kBoardingPages;
  final _pageController = PageController();
  int _currentIndex = 0;

  bool get _isLastPage => _currentIndex == pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_isLastPage) {
      widget.onFinish();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Visibility(
                  visible: !_isLastPage,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: TextButton(
                    // Navigate to last page with animation
                    onPressed: () {
                      _pageController.animateToPage(
                        pages.length - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      'Skip',
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(model: pages[index]);
                },
              ),
            ),
            OnboardingBottomWidget(
              controller: _pageController,
              pagesCount: pages.length,
              isLastPage: _isLastPage,
              onPressed: _onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}
