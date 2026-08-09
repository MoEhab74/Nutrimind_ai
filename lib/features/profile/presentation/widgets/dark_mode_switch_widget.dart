import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind_ai/core/theme/themes/app_themes.dart';
import 'package:nutrimind_ai/core/theme/themes/manager/theme_cubit.dart';
import 'package:nutrimind_ai/core/theme/themes/manager/theme_state.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    log('DarkModeSwitch has been rebuilt');

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeCubit = context.read<ThemeCubit>();
        final isDarkMode = themeCubit.currentTheme == AppTheme.dark;

        final colorScheme = Theme.of(context).colorScheme;

        return Switch.adaptive(
          value: isDarkMode,

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
          
          onChanged: (val) {
            themeCubit.toggleTheme();
          },
        );
      },
    );
  }
}