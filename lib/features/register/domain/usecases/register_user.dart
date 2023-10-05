import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/core/usecase/usecase.dart';
import 'package:cifo_flutter/features/register/domain/entities/register_params.dart';
import 'package:cifo_flutter/features/register/domain/repositories/register_repository.dart';



class RegisterUser implements UseCase<Response, RegisterParams> {
  final RegisterRepository repository;

  RegisterUser({required this.repository});

  @override
  Future<Either<Failure, Response>> call(RegisterParams params) async {
    return await repository.registerUser(params);
  }
}
