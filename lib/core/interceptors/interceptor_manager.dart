import 'package:cifo_flutter/core/http/dio_client_mix.dart';
import 'package:cifo_flutter/core/interceptors/auth_interceptor.dart';
import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';


class InterceptorManager {
  final DioClientMix dioClientMix;
  final SecureStorage secureStorage;

  InterceptorManager({
    required this.secureStorage,
    required this.dioClientMix,
  }) {
    dioClientMix.interceptors.addAll(listInterceptors());
  }

  List<Interceptor> listInterceptors() {
    return [
      LogInterceptor(),
      AuthInterceptor(
        secureStorage: secureStorage,
      ),
    ];
  }
}
