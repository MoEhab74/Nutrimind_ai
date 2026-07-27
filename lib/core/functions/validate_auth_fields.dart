import 'package:nutrimind_ai/core/utils/app_strings.dart';

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return AppStrings.emailIsRequired;
  }
  // Use REGEX to validate email format
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(email)) {
    return AppStrings.invalidEmailFormat;
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return AppStrings.passwordIsRequired;
  }
  if (password.length < 6) {
    return AppStrings.passwordMinLength;
  }
  return null;
}

String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return AppStrings.confirmPasswordIsRequired;
  }
  if (confirmPassword != password) {
    return AppStrings.passwordsDoNotMatch;
  }
  return null;
}
