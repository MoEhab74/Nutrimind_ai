import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import '../metric_input.dart';
import '../section_title.dart';
import '../step_header.dart';

class VitalsStepBody extends StatelessWidget {
  final double height;
  final double weight;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<double> onWeightChanged;

  const VitalsStepBody({
    super.key,
    required this.height,
    required this.weight,
    required this.onHeightChanged,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepHeader(
            title: 'Body Vitals',
            description:
                'Your height and weight are used to calculate accurate BMR, TDEE, and macronutrient targets.',
          ),
          const SectionTitle(title: 'Height'),
          const AppSizedBox(height: 12),
          MetricInput(
            value: height.round().toString(),
            unit: 'cm',
            onIncrement: () => onHeightChanged(height + 1),
            onDecrement: () {
              if (height > 50) {
                onHeightChanged(height - 1);
              }
            },
          ),
          const AppSizedBox(height: 24),
          const SectionTitle(title: 'Current Weight'),
          const AppSizedBox(height: 12),
          MetricInput(
            value: weight.toStringAsFixed(1),
            unit: 'kg',
            onIncrement: () => onWeightChanged(weight + 0.5),
            onDecrement: () {
              if (weight > 1.0) {
                onWeightChanged(weight - 0.5);
              }
            },
          ),
          const AppSizedBox(height: 24),
        ],
      ),
    );
  }
}
