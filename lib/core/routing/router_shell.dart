import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind_ai/core/layout/bottom_nav_bar.dart';

class RouterShell extends StatelessWidget {
  const RouterShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final normalizedIndex = navigationShell.currentIndex;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          navigationShell,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBar(
              currentIndex: normalizedIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == normalizedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
