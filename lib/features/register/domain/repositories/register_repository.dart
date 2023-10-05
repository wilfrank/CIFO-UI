import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/register/domain/entities/register_params.dart';


abstract class RegisterRepository {
  Future<Either<Failure, Response>> registerUser(RegisterParams registerParams);
}
