import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import '../review_tile.dart';
import '../step_header.dart';

class ReviewStepBody extends StatelessWidget {
  final ProfileSetupModel profile;
  final ValueChanged<int> onEditStep;

  const ReviewStepBody({
    super.key,
    required this.profile,
    required this.onEditStep,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Review Profile',
            description:
                'Double-check your parameters before we generate your customized AI nutrition baseline.',
          ),
          ReviewTile(
            icon: Icons.person,
            label: 'Biological Sex & Age',
            value:
                '${_genderText(profile.gender)}, ${profile.age ?? 28} years',
            onEdit: () => onEditStep(0),
          ),
          const AppSizedBox(height: 12),
          ReviewTile(
            icon: Icons.flag,
            label: 'Primary Goal',
            value:
                '${_goalText(profile.goal)} (Target: ${(profile.targetWeight ?? 65.0).toStringAsFixed(1)} kg)',
            onEdit: () => onEditStep(1),
          ),
          const AppSizedBox(height: 12),
          ReviewTile(
            icon: Icons.straighten,
            label: 'Height & Weight',
            value:
                '${(profile.height ?? 170.0).round()} cm / ${(profile.weight ?? 70.0).toStringAsFixed(1)} kg',
            onEdit: () => onEditStep(2),
          ),
          const AppSizedBox(height: 12),
          ReviewTile(
            icon: Icons.directions_run,
            label: 'Activity Level',
            value: _activityText(profile.activity),
            onEdit: () => onEditStep(3),
          ),
          const AppSizedBox(height: 24),
        ],
      ),
    );
  }

  String _genderText(Gender? g) {
    switch (g) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
      case null:
        return 'Female';
    }
  }

  String _goalText(Goal? g) {
    switch (g) {
      case Goal.loseWeight:
        return 'Lose Weight';
      case Goal.gainMuscle:
        return 'Gain Muscle';
      case Goal.maintainWeight:
        return 'Maintain Weight';
      case null:
        return 'Lose Weight';
    }
  }

  String _activityText(ActivityLevel? a) {
    switch (a) {
      case ActivityLevel.sedentary:
        return 'Sedentary';
      case ActivityLevel.lightlyActive:
        return 'Lightly Active';
      case ActivityLevel.moderatelyActive:
        return 'Moderately Active';
      case ActivityLevel.active:
        return 'Active';
      case ActivityLevel.veryActive:
        return 'Very Active';
      case null:
        return 'Moderately Active';
    }
  }
}
