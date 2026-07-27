import 'package:nutrimind_ai/core/api/api_endpoints.dart';

class ErrorModel {
  // These fields should match the structure of the error response from your API
  final String message;
  final int? statusCode;

  ErrorModel({required this.message, this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    message: json[ApiKeys.message],
    statusCode: json[ApiKeys.statusCode],
  );
}
