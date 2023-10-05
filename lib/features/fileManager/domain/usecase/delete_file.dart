import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cifo_flutter/features/fileManager/data/models/file_model.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/fileManager/domain/repositories/file_manager_repository.dart';
import 'package:cifo_flutter/core/usecase/usecase.dart';

class DeleteFile implements UseCase<Response, FileModel> {
  final FileManagerRepository repository;

  DeleteFile({required this.repository});

  @override
  Future<Either<Failure, Response>> call(FileModel params) {
    return repository.deleteFile(params);
  }
}
