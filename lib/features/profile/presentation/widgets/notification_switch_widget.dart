import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/cache/cache_helper.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/services/notification_service.dart';

class NotificationsSwitch extends StatefulWidget {
  const NotificationsSwitch({super.key});

  @override
  State<NotificationsSwitch> createState() => _NotificationsSwitchState();
}

class _NotificationsSwitchState extends State<NotificationsSwitch> {
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final enabled = getIt<CacheHelper>().getData(key: 'kNotificationsEnabled');

    if (!mounted) return;

    setState(() {
      _notificationsEnabled = enabled ?? false;
    });
  }

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

      onChanged: (val) async {
        setState(() {
          _notificationsEnabled = val;
        });

        await getIt<CacheHelper>().saveData(
          key: 'kNotificationsEnabled',
          value: val,
        );

        if (val) {
          await getIt<NotificationService>().scheduleMealReminders();
        } else {
          await getIt<NotificationService>().cancelAll();
        }
      },
    );
  }
}
