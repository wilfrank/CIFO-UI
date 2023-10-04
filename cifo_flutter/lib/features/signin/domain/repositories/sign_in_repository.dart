import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/signin/domain/entities/sign_in_entity.dart';
// import 'package:cifo_flutter/features/signin/domain/entities/sign_in_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


abstract class SignInRepository {
  Future<Either<Failure, Response>> signInUser(SignInEntity signInEntity);
}
