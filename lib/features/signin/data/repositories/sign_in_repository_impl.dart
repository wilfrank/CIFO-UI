import 'package:dartz/dartz.dart';
import 'package:cifo_flutter/core/errors/exceptions.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';
import 'package:cifo_flutter/features/signin/data/datasources/sign_in_remote_datasource.dart';
import 'package:cifo_flutter/features/signin/domain/entities/sign_in_entity.dart';
// import 'package:cifo_flutter/features/signin/domain/entities/sign_in_response.dart';
import 'package:cifo_flutter/features/signin/domain/repositories/sign_in_repository.dart';
import 'package:dio/dio.dart';

class SignInRepositoryImplementation extends SignInRepository {
  final SignInRemoteDataSource signinRemoteDataSource;
  final SecureStorage secureStorage;

  SignInRepositoryImplementation({
    required this.signinRemoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, Response>> signInUser(
      SignInEntity signInEntity) async {
    try {
      final signInResponseModel = await signinRemoteDataSource.loginUser(
        signInEmail: signInEntity,
      );
      return Right(signInResponseModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
