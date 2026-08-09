import 'dart:developer';

import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Switch.adaptive(
      value: _notificationsEnabled,
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.transparent;
        }
        return colorScheme.outlineVariant;
      }),
      trackOutlineWidth: WidgetStateProperty.all(1.2),

      activeThumbColor: colorScheme.onPrimary,
      activeTrackColor: colorScheme.primary,

      inactiveThumbColor: colorScheme.outline,
      inactiveTrackColor: colorScheme.surfaceContainerLow,

      onChanged: (val) => setState(() => _notificationsEnabled = val),
    );
  }
}