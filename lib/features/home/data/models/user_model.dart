class UserModel {
  final String? fullName;
  final String? emailAddress;
  final String? gender;
  final String? age;
  final String? weight;
  final String? height;
  final String? targetWeight;
  final String? goal;

  UserModel({
    this.fullName,
    this.emailAddress,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.targetWeight,
    this.goal,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json['fullName'] as String?,
        emailAddress: json['emailAddress'] as String?,
        gender: json['gender'] as String?,
        age: json['age']?.toString(),
        weight: json['weight']?.toString(),
        height: json['height']?.toString(),
        targetWeight: json['targetWeight']?.toString(),
        goal: json['goal'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'emailAddress': emailAddress,
    'gender': gender,
    'age': age,
    'weight': weight,
    'height': height,
    'targetWeight': targetWeight,
    'goal': goal,
  };

}