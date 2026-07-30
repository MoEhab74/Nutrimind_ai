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
    log('NotificationsSwitch has been rebuild');
    return Switch.adaptive(
      value: _notificationsEnabled,
      activeThumbColor: AppColors.primary,
      onChanged: (val) => setState(() => _notificationsEnabled = val),
    );
  }
}