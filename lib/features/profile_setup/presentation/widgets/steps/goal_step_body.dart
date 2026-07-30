import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import '../metric_input.dart';
import '../section_title.dart';
import '../selection_card_widget.dart';
import '../step_header.dart';

class GoalStepBody extends StatelessWidget {
  final Goal selectedGoal;
  final double targetWeight;
  final ValueChanged<Goal> onGoalChanged;
  final ValueChanged<double> onTargetWeightChanged;

  const GoalStepBody({
    super.key,
    required this.selectedGoal,
    required this.targetWeight,
    required this.onGoalChanged,
    required this.onTargetWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Your Primary Goal',
            description:
                'Select your main target so NutriMind AI can tailor your personalized nutritional plan.',
          ),
          const SectionTitle(title: 'Choose a Goal'),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Lose Weight',
            subtitle: 'Drop body fat while preserving lean muscle mass',
            icon: Icons.trending_down,
            isSelected: selectedGoal == Goal.loseWeight,
            onTap: () => onGoalChanged(Goal.loseWeight),
          ),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Gain Muscle',
            subtitle: 'Build strength and add healthy body mass',
            icon: Icons.fitness_center,
            isSelected: selectedGoal == Goal.gainMuscle,
            onTap: () => onGoalChanged(Goal.gainMuscle),
          ),
          const AppSizedBox(height: 12),
          SelectionCard(
            title: 'Maintain Weight',
            subtitle: 'Optimize overall health, energy, and vitality',
            icon: Icons.balance,
            isSelected: selectedGoal == Goal.maintainWeight,
            onTap: () => onGoalChanged(Goal.maintainWeight),
          ),
          const AppSizedBox(height: 24),
          const SectionTitle(title: 'Target Weight'),
          const AppSizedBox(height: 12),
          MetricInput(
            value: targetWeight.toStringAsFixed(1),
            unit: 'kg',
            onIncrement: () => onTargetWeightChanged(targetWeight + 0.5),
            onDecrement: () {
              if (targetWeight > 1.0) {
                onTargetWeightChanged(targetWeight - 0.5);
              }
            },
          ),
          const AppSizedBox(height: 24),
        ],
      ),
    );
  }
}
