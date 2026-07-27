import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _highlightedIndex;

  @override
  void initState() {
    super.initState();
    _highlightedIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _highlightedIndex = widget.currentIndex;
  }

  List<NavigationDestination> _destinations() {
    final theme = Theme.of(context);
        return [
          NavigationDestination(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              size: 24,
              color: theme.colorScheme.primary,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedChat,
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedChat,
              size: 24,
              color: theme.colorScheme.primary,
            ),
            label: "Ask AI",
          ),
          NavigationDestination(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedWorkHistory,
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedWorkHistory,
              size: 24,
              color: theme.colorScheme.primary,
            ),
            label: "History",
          ),
          NavigationDestination(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            selectedIcon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              size: 24,
              color: theme.colorScheme.primary,
            ),
            label: "Profile",
          ),
        ];
      
    }
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 12.h),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 20.r,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            height: 64.h,
            selectedIndex: _highlightedIndex,
            onDestinationSelected: widget.onTap,
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return TextStyle(
                  fontSize: 9.sp,
                  color: theme.colorScheme.primary,
                );
              }
              return TextStyle(fontSize: 9.sp);
            }),
            destinations: _destinations(),
          ),
        ),
      ),
    );
  }
}
