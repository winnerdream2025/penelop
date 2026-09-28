import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  final String Function() getLang;
  final String? Function() getToken;

  AppInterceptor({required this.getLang, required this.getToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final lang = getLang();
    options.queryParameters.putIfAbsent('lang', () => lang);

    final token = getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}
