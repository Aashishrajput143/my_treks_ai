import 'package:dio/dio.dart';

import '../controller/authController_refreshToken.dart';

class TokenRefreshInterceptor extends QueuedInterceptor {
  final Dio dio;
  final AuthController authController;

  TokenRefreshInterceptor(this.dio, this.authController);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['accesstoken'] = authController.accessToken.value ?? '';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the error is due to session expiration
    if (err.response?.statusCode == 463) {
      try {
        // Refresh the token
        await authController.refreshTokenApi();

        // Retry the original request with the new access token
        err.requestOptions.headers['accesstoken'] = authController.accessToken.value ?? '';
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response); // Return the successful response
      } catch (e) {
        // If token refresh fails, propagate the error
        handler.next(DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: "Token refresh failed: $e",
        ));
      }
    } else {
      handler.next(err); // Pass along any other errors
    }
  }
}
