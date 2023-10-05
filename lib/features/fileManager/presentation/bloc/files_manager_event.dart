part of 'files_manager_bloc.dart';

abstract class FileManagerEvent extends Equatable {
  final List<FileModel> files;
  const FileManagerEvent({required this.files});
  @override
  List<dynamic> get props => files;
}

class FileManagerInitializeEvent extends FileManagerEvent {
  const FileManagerInitializeEvent({required List<FileModel> filesModel})
      : super(files: filesModel);
}

class AuthenticateFileEvent extends FileManagerEvent {
  final FileModel fileModel;
  const AuthenticateFileEvent(
      {required List<FileModel> filesModel, required this.fileModel})
      : super(files: filesModel);
}

class DeleteFileEvent extends FileManagerEvent {
  final FileModel fileModel;
  const DeleteFileEvent({required List<FileModel> filesModel, required this.fileModel})
      : super(files: filesModel);
}

class GetFilesEvent extends FileManagerEvent {
  const GetFilesEvent({required List<FileModel> filesModel})
      : super(files: filesModel);
}
