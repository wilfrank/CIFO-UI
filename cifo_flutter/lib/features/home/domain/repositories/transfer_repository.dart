import 'package:cifo_flutter/features/home/domain/entities/transfer_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/failures.dart';


abstract class TransferRepository {
  Future<Either<Failure, Response>> transferUser(TransferParams transferParams);
}
