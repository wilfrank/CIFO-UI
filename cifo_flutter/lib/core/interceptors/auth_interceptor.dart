import 'package:cifo_flutter/core/constants/api.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/base/base_remote_data_source.dart';
import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';

class AuthInterceptor extends Interceptor with BaseRemoteDataSourceImpl {
  final SecureStorage secureStorage;

  AuthInterceptor({
    required this.secureStorage,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path != API.apiSignUp) {
      if (options.path != API.apiLogIn) {
        if (options.path == API.apiGetFiles) {
          final String userToken =
              // await secureStorage.getSecuredUserToken();
              secureStorage.getLocalId();
          options.queryParameters = {"key": userToken};
        }

        try {
          final String bearerToken =
              // await secureStorage.getSecuredRefreshToken();
              secureStorage.getToken();
          options.headers['Authorization'] = 'Bearer $bearerToken';
        } catch (e) {
          rethrow;
        }
      }
    }
    print(" --- Data: ---");
    print(options.data);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.path == API.apiLogIn) {
      final firebaseToken = response.data["firebaseToken"];
      // print(firebaseToken);
      final localId = response.data["user"]["localId"];
      // print(localId);
      secureStorage.setToken(firebaseToken);
      // await secureStorage.secureRefreshToken(
      //     tokenToSecure: firebaseToken);
      secureStorage.setLocalId(localId);
      // await secureStorage.secureUserToken(tokenToSecure: localId);
    } else if (response.requestOptions.path == API.apiGetFiles) {
      final cedula = response.data["identityNumber"];
      print("Cedula");
      print(cedula);
      secureStorage.setCedula(cedula);
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    super.onError(err, handler);
  }
}
