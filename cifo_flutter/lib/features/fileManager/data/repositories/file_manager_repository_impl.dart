import 'package:cifo_flutter/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/fileManager/data/datasource/file_manager_remote_data_source.dart';
import 'package:cifo_flutter/features/fileManager/data/models/file_model.dart';
import 'package:cifo_flutter/features/fileManager/domain/repositories/file_manager_repository.dart';

class FileManagerRepositoryImpl extends FileManagerRepository {
  final FileManagerRemoteDataSource fileManagerRemoteDataSource;

  FileManagerRepositoryImpl({
    required this.fileManagerRemoteDataSource,
  });

  @override
  Future<Either<Failure, Response>> authenticateFile(
      FileModel fileModel) async {
    try {
      final responseFile = await fileManagerRemoteDataSource.authenticateFile(fileModel);

      return Right(responseFile);
    } on ServerException catch (e) {
      print("Error Auth");
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Response>> deleteFile(FileModel fileModel) async {
    try {
      final responseFile = await fileManagerRemoteDataSource.deleteFile(fileModel);

      return Right(responseFile);
    } on ServerException catch (e) {
      print("Error Delete");
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<FileModel>>> getFiles() async {
     try {
      final responseFiles = await fileManagerRemoteDataSource.getFiles();
      return Right(responseFiles);
    } on ServerException catch (e) {
      print("Error Get Files");
      return Left(ServerFailure(e.message));
    }
  }
}
