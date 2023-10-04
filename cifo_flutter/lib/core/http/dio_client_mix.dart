import 'dart:io';

import 'package:cifo_flutter/core/base/base_remote_data_source.dart';
import 'package:cifo_flutter/core/constants/api.dart';
import 'package:dio/dio.dart';

class DioClientMix with DioMixin, BaseRemoteDataSourceImpl implements Dio {
  Dio client;

  DioClientMix({required this.client}) {
    _configBaseOptions();
  }

  void _configBaseOptions() {
    final options = BaseOptions(
      baseUrl: API.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.connectionHeader: 'keep-alive',
      },
    );
    client.options = options;
  }

  @override
  HttpClientAdapter get httpClientAdapter => HttpClientAdapter();

  @override
  Interceptors get interceptors => client.interceptors;

  String _setUrlLang(String path) => path;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await client.get(
        _setUrlLang(path),
        options: options,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await client.post(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await client.delete(
        _setUrlLang(path),
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      return handleError(e);
    }
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await client.put(
        path,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      return handleError(e);
    }
  }
}
