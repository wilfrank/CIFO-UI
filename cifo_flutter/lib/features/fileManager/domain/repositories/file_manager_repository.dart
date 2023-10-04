import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/fileManager/data/models/file_model.dart';

abstract class FileManagerRepository {
  Future<Either<Failure, List<FileModel>>> getFiles();
  Future<Either<Failure, Response>> deleteFile(FileModel fileModel);
  Future<Either<Failure, Response>> authenticateFile(FileModel fileModel);
}
