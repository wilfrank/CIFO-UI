import 'package:cifo_flutter/features/home/data/datasources/transfer_remote_data_source.dart';
import 'package:cifo_flutter/features/home/domain/entities/transfer_params.dart';
import 'package:cifo_flutter/features/home/domain/repositories/transfer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/exceptions.dart';
import 'package:cifo_flutter/core/errors/failures.dart';

class TransferRepositoryImplementation extends TransferRepository {
  final TransferRemoteDataSource transferRemoteDataSource;

  TransferRepositoryImplementation({
    required this.transferRemoteDataSource,
  });

  @override
  Future<Either<Failure, Response>> transferUser(
      TransferParams transferParams) async {
    try {
      final transferResponse = await transferRemoteDataSource.transferUser(
        transferParams: transferParams,
      );

      return Right(transferResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
