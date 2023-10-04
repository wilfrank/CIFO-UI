import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/uploadFile/data/models/file_upload_model.dart';
import 'package:cifo_flutter/features/uploadFile/domain/repositories/file_upload_manager_repository.dart';
import 'package:cifo_flutter/core/usecase/usecase.dart';

class UploadFileUseCase implements UseCase<Response, FileUploadModel> {
  final FileUploadManagerRepository repository;

  UploadFileUseCase({required this.repository});

  @override
  Future<Either<Failure, Response>> call(FileUploadModel params) {
    return repository.uploadFile(params);
  }
}
