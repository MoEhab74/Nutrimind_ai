import 'dart:async';

import 'package:dio/dio.dart';
import 'package:nutrimind_ai/core/api/api_endpoints.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/core/services/is_logged_in_service.dart';
import 'package:nutrimind_ai/core/services/tokens_secure_service.dart';

class ApiInterceptor extends Interceptor {
  final Dio dio;
  // Completer acts like a queue for requests that come in while a token refresh is already in progress.
  // The acctual job of the Completer is to Prevents multiple refresh token requests from happening simultaneously.
  static Completer<bool>? _refreshTokenCompleter;
  ApiInterceptor(this.dio);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await getIt<TokensSecureService>().getAccessToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }

  // What's requestOptions?
  // Dio under the hood has an object called requestOptions which is an object that contains all the details of the HTTP request.
  // It includes information such as the URL, HTTP method, headers, body, and any other parameters that were part of the request.
  // When we want to retry the original request after refreshing the token, we use requestOptions to ensure that we are sending the same request with the new access token.

  // So, where and when dio save the requestOptions?
  // This object existed in the DioException
  // When a request is made using Dio, it creates a RequestOptions object that encapsulates all the details of that request.

  // Why we retry the request with dio.fetch() instead of any other method?
  // Because we don't know if the request was get, post, put, delete, etc.
  // The requestOptions contains the HTTP method and all the necessary information to make the request exactly as it was originally intended.

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //debugPrint('Error Status Code: ${err.response?.statusCode}');

    if (err.response?.statusCode == 401) {
      if (_refreshTokenCompleter != null) {
        // Queue the request until the existing refresh process is completed ===> Line 66
        final success = await _refreshTokenCompleter!.future;

        if (success) {
          final accessToken = await getIt<TokensSecureService>()
              .getAccessToken();

          //debugPrint('Retrying original request...');
          err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
          // Try to retry original request with the current access token (which may have been refreshed by the ongoing refresh process)
          try {
            final response = await dio.fetch(err.requestOptions);
            // handler.resolve(response) tells dio that the request has been resolved successfully and there is no errors now.
            return handler.resolve(response);
          } catch (e) {
            // The opposite of handler.resolve(response).
            // handler.next(err) tells dio that there is still an error and it should continue with the error handling process.
            return handler.next(err);
          }
        } else {
          return handler.next(err);
        }
      }

      // Start of the Refresh Token Process.
      // The flow of the refresh token process starts from here.
      // Create the queue for the incoming requests while refresh token process is in progress.
      _refreshTokenCompleter = Completer<bool>();

      final refreshToken = await getIt<TokensSecureService>().getRefreshToken();

      //debugPrint('Refresh Token: $refreshToken');

      if (refreshToken == null) {
        //debugPrint('No refresh token found');

        // Queue has been created but we can't refresh, so close the queue (Completer) and logout
        _refreshTokenCompleter!.complete(false);
        _refreshTokenCompleter = null;
        await _performLogout();
        //
        return handler.next(err);
      }

      // Here is the actual refresh process, all incoming requests will wait until this process is completed (success or failure).
      // We use a new Dio instance to avoid interceptors loop, because if we use the same Dio instance,
      // it will trigger the onError again if the refresh request also returns 401, which will cause an infinite loop.
      try {
        final refreshDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
        final response = await refreshDio.post(
          ApiEndpoints.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        // Get the new access token and refresh token from the response and save them securely

        final newAccessToken = response.data[ApiKeys.accessToken] as String?;

        final newRefreshToken = response.data[ApiKeys.refreshToken] as String?;

        await getIt<TokensSecureService>().saveTokens(
          accessToken: newAccessToken!,
          refreshToken: newRefreshToken!,
        );

        // Refresh successful, complete the queue (Completer) with success = true, so all waiting requests can retry with the new token

        _refreshTokenCompleter!.complete(true);
        _refreshTokenCompleter = null;

        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await dio.fetch(err.requestOptions);

        //debugPrint('Final request success');

        return handler.resolve(retryResponse);
      } catch (e) {
        //debugPrint('Refresh process failed: $e');

        _refreshTokenCompleter!.complete(false);
        _refreshTokenCompleter = null;
        await _performLogout();

        return handler.next(err);
      }
    }

    return super.onError(err, handler);
  }

  Future<void> _performLogout() async {
    await getIt<TokensSecureService>().clearTokens();
    await getIt<IsLoggedInService>().clearLoggedIn();
    // Where we can listen to this event in the app?
    // We can listen to this event in the main.dart, where we can navigate to the login screen
    // when the user is logged out due to token refresh failure.
    AuthEventBus.instance.addEvent(AuthEvent.logout);
  }
}

// Because Interceptor processes is done in the background,
// we need a way to notify the whole app when the user is logged out due to token refresh failure,
// so we use an event bus to broadcast the logout event to the app, and the app can listen to this event and navigate to the login screen or show a message to the user.

enum AuthEvent { logout }

class AuthEventBus {
  // Singleton so that we have only one stream station for the whole app,
  // so all parts of the app can listen to the same stream for auth events.
  AuthEventBus._();
  static final AuthEventBus instance = AuthEventBus._();

  final _controller = StreamController<AuthEvent>.broadcast();

  Stream<AuthEvent> get stream => _controller.stream;

  void addEvent(AuthEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() => _controller.close();
}
