import 'package:dio/dio.dart';
import 'package:flutter_delivery_app/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청 보낼 때
  // 요청이 보내질때마다
  // 만약에 요청의 Header 에 accessToken: true 라는 값이 있다면
  // 실제 토큰을 가져와서 (from storage) authorization: bearer $token 으로
  // 헤더를 변경한다.

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print('[REQ]\n'
        'method: ${options.method}\n'
        'uri: ${options.uri}\n'
        'headers: ${options.headers}\n');

    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        // KEY : Value
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        // KEY : Value
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler); // 요청 보내는 함수.
  }

  // 2) 응답을 받을 때
  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
  }

  // 3) 에러가 났을 때
  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // 401 에러가 났을 때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급 되면
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERR]\n'
        'method: ${err.requestOptions.method}\n'
        'uri: ${err.requestOptions.uri}\n'
        'headers: ${err.requestOptions.headers}\n');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err);
    }
    super.onError(err, handler);
  }
}
