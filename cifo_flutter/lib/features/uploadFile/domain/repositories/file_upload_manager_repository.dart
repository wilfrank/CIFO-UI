import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/uploadFile/data/models/file_upload_model.dart';

abstract class FileUploadManagerRepository {
  Future<Either<Failure, Response>> uploadFile(FileUploadModel fileUploadModel);
}
