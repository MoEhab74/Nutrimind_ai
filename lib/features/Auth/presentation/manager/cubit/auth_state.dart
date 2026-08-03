class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpLoadingState extends AuthState {}

final class SignUpSuccessState extends AuthState {}

final class SignUpFailureState extends AuthState {
  final String errorMessage;
  SignUpFailureState(this.errorMessage);
}

final class SignInLoadingState extends AuthState {}

final class SignInSuccessState extends AuthState {}

final class SignInFailureState extends AuthState {
  final String errorMessage;
  SignInFailureState(this.errorMessage);
}

final class SignOutLoadingState extends AuthState {}

final class SignOutSuccessState extends AuthState {}

final class SignOutFailureState extends AuthState {
  final String errorMessage;
  SignOutFailureState(this.errorMessage);
}

