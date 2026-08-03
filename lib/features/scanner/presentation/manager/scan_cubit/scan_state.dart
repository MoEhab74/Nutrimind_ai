part of 'scan_cubit.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}

final class ScanLoading extends ScanState {}

final class ScanSuccess extends ScanState {
  final FoodModel food;
  ScanSuccess({required this.food});
}

final class ScanError extends ScanState {
  final String errorMessage;
  ScanError({required this.errorMessage});
}
