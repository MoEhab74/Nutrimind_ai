enum Gender {
  male,
  female,
  other,
}

enum Goal {
  loseWeight,
  gainMuscle,
  maintainWeight,
}

enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  active,
  veryActive,
}

class ProfileSetupModel {
  final Gender? gender;
  final int? age;

  final double? height;
  final double? weight;

  final Goal? goal;
  final double? targetWeight;

  final ActivityLevel? activity;

  const ProfileSetupModel({
    this.gender,
    this.age,
    this.height,
    this.weight,
    this.goal,
    this.targetWeight,
    this.activity,
  });

  ProfileSetupModel copyWith({
    Gender? gender,
    int? age,
    double? height,
    double? weight,
    Goal? goal,
    double? targetWeight,
    ActivityLevel? activity,
  }) {
    return ProfileSetupModel(
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      targetWeight: targetWeight ?? this.targetWeight,
      activity: activity ?? this.activity,
    );
  }
}