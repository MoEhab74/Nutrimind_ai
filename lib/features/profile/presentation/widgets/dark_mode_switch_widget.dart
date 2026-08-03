import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool _darkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    log('NotificationsSwitch has been rebuilt');
    return Switch.adaptive(
      value: _darkModeEnabled,
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.transparent; 
        }
        return AppColors.outlineVariant; 
      }),
      trackOutlineWidth: WidgetStateProperty.all(1.2),
      activeThumbColor: AppColors.onPrimary,
      activeTrackColor: AppColors.primary,

      inactiveThumbColor: AppColors.outline,
      inactiveTrackColor: AppColors.surfaceLow, 
      onChanged: (val) => setState(() => _darkModeEnabled = val),
    );
  }
}
