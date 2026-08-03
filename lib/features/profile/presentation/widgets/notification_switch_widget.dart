import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';

class NotificationsSwitch extends StatefulWidget {
  const NotificationsSwitch({super.key});

  @override
  State<NotificationsSwitch> createState() => _NotificationsSwitchState();
}

class _NotificationsSwitchState extends State<NotificationsSwitch> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    log('NotificationsSwitch has been rebuilt');
    return Switch.adaptive(
      value: _notificationsEnabled,
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

      onChanged: (val) => setState(() => _notificationsEnabled = val),
    );
  }
}