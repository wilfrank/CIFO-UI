import 'package:dartz/dartz.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/fileManager/data/models/file_model.dart';
import 'package:cifo_flutter/features/fileManager/domain/repositories/file_manager_repository.dart';
import 'package:cifo_flutter/core/usecase/usecase.dart';

class GetFiles implements UseCase<List<FileModel>, NoParams> {
  final FileManagerRepository repository;

  GetFiles({required this.repository});

  @override
  Future<Either<Failure, List<FileModel>>> call(NoParams params) {
    return repository.getFiles();
  }
}
