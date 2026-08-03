
class ErrorModel {
  // These fields should match the structure of the error response from your API
  final String message;
  final int? statusCode;

  ErrorModel({required this.message, this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json['message'] ??
            (json['error'] is Map ? json['error']['message'] : null) ??
            'An error occurred. Please try again.',
        statusCode: json['statusCode'] ??
            (json['error'] is Map ? json['error']['code'] : null),
      );
}
