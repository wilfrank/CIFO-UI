import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/features/home/domain/entities/transfer_params.dart';
import 'package:cifo_flutter/features/home/domain/repositories/transfer_repository.dart';

import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/core/usecase/usecase.dart';



class TransferUser implements UseCase<Response, TransferParams> {
  final TransferRepository repository;

  TransferUser({required this.repository});

  @override
  Future<Either<Failure, Response>> call(TransferParams params) async {
    return await repository.transferUser(params);
  }
}
