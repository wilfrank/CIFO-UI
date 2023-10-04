import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/exceptions.dart';

abstract class BaseRemoteDataSource {
  dynamic handleError(DioException e);
}

mixin BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  @override
  handleError(DioException e) {
    final statusCode = e.response!.statusCode ?? 500;
    throw ServerException(message: e.message.toString(), errorCode: statusCode);
  }
}
