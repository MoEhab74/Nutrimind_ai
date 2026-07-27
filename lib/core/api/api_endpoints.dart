class ApiEndpoints {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/';
  static const String login = 'auth/login';
  static const String createUser = 'users/';
  static const String refreshToken = 'auth/refresh-token';
  static const String profile = 'auth/profile';
  static const String products = 'products';
  static const String categories = 'categories';
  static String productsByCategory(String categoryId) {
    return 'products/?categoryId=$categoryId';
  }
}

class ApiKeys {
  static const String message = 'message';
  static const String statusCode = 'statusCode';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
}
