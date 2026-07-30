import 'package:flutter/material.dart';
import 'package:nutrimind_ai/core/theme/styles/app_colors.dart';
import 'package:nutrimind_ai/core/theme/styles/app_text_styles.dart';
import 'package:nutrimind_ai/core/widgets/app_sized_box.dart';
import 'package:nutrimind_ai/features/profile_setup/data/models/profile_setup_model.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/age_picker_card._widget.dart';
import 'package:nutrimind_ai/features/profile_setup/presentation/widgets/selection_card_widget.dart';

class AboutYouBody extends StatelessWidget {
  final Gender selectedSex;
  final int age;
  final ValueChanged<Gender> onSexSelected;
  final VoidCallback onAgeIncrement;
  final VoidCallback onAgeDecrement;

  const AboutYouBody({
    super.key,
    required this.selectedSex,
    required this.age,
    required this.onSexSelected,
    required this.onAgeIncrement,
    required this.onAgeDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About You',
              style: AppTextStyles.semiBold28.copyWith(
                color: AppColors.onBackground,
              ),
            ),
            const AppSizedBox(height: 8),
            Text(
              'Biological sex and age help us calculate your baseline metabolic needs with clinical precision.',
              style: AppTextStyles.regular16.copyWith(
                color: AppColors.outline,
              ),
            ),
            const AppSizedBox(height: 24),
            Text(
              'Biological Sex',
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const AppSizedBox(height: 12),
            SelectionCard(
              title: 'Male',
              icon: Icons.male,
              isSelected: selectedSex == Gender.male,
              onTap: () => onSexSelected(Gender.male),
            ),
            const AppSizedBox(height: 12),
            SelectionCard(
              title: 'Female',
              icon: Icons.female,
              isSelected: selectedSex == Gender.female,
              onTap: () => onSexSelected(Gender.female),
            ),
            const AppSizedBox(height: 12),
            SelectionCard(
              title: 'Other',
              icon: Icons.transgender,
              isSelected: selectedSex == Gender.other,
              onTap: () => onSexSelected(Gender.other),
            ),
            const AppSizedBox(height: 24),
            Text(
              'How old are you?',
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const AppSizedBox(height: 12),
            AgePickerCard(
              age: age,
              onIncrement: onAgeIncrement,
              onDecrement: onAgeDecrement,
            ),
            const AppSizedBox(height: 24),
          ],
        ),
      );
  }
}
