import 'package:dio/dio.dart';
import 'package:nutrimind_ai/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Connection Timeout'},
          ),
        );
      case DioExceptionType.sendTimeout:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Send Timeout'},
          ),
        );
      case DioExceptionType.receiveTimeout:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Receive Timeout'},
          ),
        );
      case DioExceptionType.badCertificate:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Bad Certificate'},
          ),
        );
      case DioExceptionType.cancel:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Request Cancelled'},
          ),
        );
      case DioExceptionType.connectionError:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Connection Error'},
          ),
        );
      case DioExceptionType.unknown:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Unknown Error'},
          ),
        );
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: // Bad request
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Bad Request'},
              ),
            );
          case 401: //unauthorized
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Unauthorized'},
              ),
            );
          case 403: //forbidden
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Forbidden'},
              ),
            );
          case 404: //not found
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Not Found'},
              ),
            );
    
          case 409: //cofficient
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Conflict'},
              ),
            );
          case 422: //  Unprocessable Entity
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Unprocessable Entity'},
              ),
            );
          case 504:
            throw ServerException(
              errorModel: ErrorModel.fromJson(
                e.response?.data ?? {'message': 'Gateway Timeout'},
              ),
            );
          default:
            throw ServerException(
              errorModel: ErrorModel(
                message: 'Something went wrong, please try again later.',
                statusCode: e.response?.statusCode,
              ),
            ); // Server exception
        }
      case DioExceptionType.transformTimeout:
        throw ServerException(
          errorModel: ErrorModel.fromJson(
            e.response?.data ?? {'message': 'Transform Timeout'},
          ),
        );
    }
        
  }

  