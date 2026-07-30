import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import '../selection_card_widget.dart';
import '../step_header.dart';

class ActivityStepBody extends StatelessWidget {
  final ActivityLevel selectedActivity;
  final ValueChanged<ActivityLevel> onActivityChanged;

  const ActivityStepBody({
    super.key,
    required this.selectedActivity,
    required this.onActivityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Activity Level',
            description:
                'How active are you on a typical week? This determines your daily energy expenditure.',
          ),
          SelectionCard(
            title: 'Sedentary',
            subtitle: 'Little to no exercise, desk job',
            icon: Icons.chair,
            isSelected: selectedActivity == ActivityLevel.sedentary,
            onTap: () => onActivityChanged(ActivityLevel.sedentary),
          ),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Lightly Active',
            subtitle: '1-3 days/week of light exercise or sports',
            icon: Icons.directions_walk,
            isSelected: selectedActivity == ActivityLevel.lightlyActive,
            onTap: () => onActivityChanged(ActivityLevel.lightlyActive),
          ),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Moderately Active',
            subtitle: '3-5 days/week of moderate workouts',
            icon: Icons.directions_run,
            isSelected: selectedActivity == ActivityLevel.moderatelyActive,
            onTap: () => onActivityChanged(ActivityLevel.moderatelyActive),
          ),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Active',
            subtitle: '6-7 days/week of hard training',
            icon: Icons.fitness_center,
            isSelected: selectedActivity == ActivityLevel.active,
            onTap: () => onActivityChanged(ActivityLevel.active),
          ),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Very Active',
            subtitle: 'Physical job or intense training twice daily',
            icon: Icons.bolt,
            isSelected: selectedActivity == ActivityLevel.veryActive,
            onTap: () => onActivityChanged(ActivityLevel.veryActive),
          ),
          const AppSizedBox(height: 24),
        ],
      ),
    );
  }
}
