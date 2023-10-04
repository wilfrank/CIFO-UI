import 'package:dartz/dartz.dart';

import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/core/usecase/usecase.dart';
import 'package:cifo_flutter/features/signin/domain/entities/sign_in_entity.dart';
// import 'package:cifo_flutter/features/signin/domain/entities/sign_in_response.dart';
import 'package:cifo_flutter/features/signin/domain/repositories/sign_in_repository.dart';
import 'package:dio/dio.dart';


class SignInUser implements UseCase<Response, SignInEntity> {
  final SignInRepository repository;

  SignInUser({required this.repository});

  @override
  Future<Either<Failure, Response>> call(SignInEntity params) async {
    return await repository.signInUser(params);
  }
}
