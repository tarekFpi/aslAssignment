import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


class AuthorizationInterceptor extends Interceptor {

  final storage = GetStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${storage.read("user_token")}';
    // continue with the request
    super.onRequest(options, handler);
  }
}