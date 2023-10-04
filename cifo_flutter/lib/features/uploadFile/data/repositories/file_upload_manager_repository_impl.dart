import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/exceptions.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/uploadFile/data/models/file_upload_model.dart';
import 'package:cifo_flutter/features/uploadFile/domain/repositories/file_upload_manager_repository.dart';
import 'package:cifo_flutter/features/uploadFile/data/datasource/file_upload_manager_remote_data_source.dart';




class FileUploadManagerRepositoryImpl extends FileUploadManagerRepository {
  final FileUploadManagerRemoteDataSource fileManagerRemoteDataSource;

  FileUploadManagerRepositoryImpl({
    required this.fileManagerRemoteDataSource,
  });

  @override
  Future<Either<Failure, Response>> uploadFile(FileUploadModel fileUploadModel) async{
        try {
      final responseFile = await fileManagerRemoteDataSource.uploadFile(fileUploadModel);

      return Right(responseFile);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

}
