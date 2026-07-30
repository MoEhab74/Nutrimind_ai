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
    log('DarkModeSwitch has been rebuild');
    return Switch.adaptive(
      value: _darkModeEnabled,
      activeThumbColor: AppColors.primary,
      onChanged: (val) => setState(() => _darkModeEnabled = val),
    );
  }
}
