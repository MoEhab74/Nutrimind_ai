import 'package:hive/hive.dart';

part 'profile_setup_model.g.dart';

@HiveType(typeId: 1)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
  @HiveField(2)
  other,
}

@HiveType(typeId: 2)
enum Goal {
  @HiveField(0)
  loseWeight,
  @HiveField(1)
  gainMuscle,
  @HiveField(2)
  maintainWeight,
}

@HiveType(typeId: 3)
enum ActivityLevel {
  @HiveField(0)
  sedentary,
  @HiveField(1)
  lightlyActive,
  @HiveField(2)
  moderatelyActive,
  @HiveField(3)
  active,
  @HiveField(4)
  veryActive,
}

@HiveType(typeId: 0)
class ProfileSetupModel {
  @HiveField(0)
  final Gender? gender;

  @HiveField(1)
  final int? age;

  @HiveField(2)
  final double? height;

  @HiveField(3)
  final double? weight;

  @HiveField(4)
  final Goal? goal;

  @HiveField(5)
  final double? targetWeight;

  @HiveField(6)
  final ActivityLevel? activity;

  const ProfileSetupModel({
    this.gender = Gender.female,
    this.age = 28,
    this.height = 170.0,
    this.weight = 70.0,
    this.goal = Goal.loseWeight,
    this.targetWeight = 65.0,
    this.activity = ActivityLevel.moderatelyActive,
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
