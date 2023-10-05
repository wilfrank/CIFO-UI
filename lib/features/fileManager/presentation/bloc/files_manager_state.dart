part of 'files_manager_bloc.dart';

abstract class FileManagerState extends Equatable {
  const FileManagerState({
    required this.files,
  });
  final List<FileModel> files;

  @override
  List<dynamic> get props => files;
}

class FileManagerInitialState extends FileManagerState {
  FileManagerInitialState() : super(files: []);
}

class FileManagerPreviewState extends FileManagerState {
  const FileManagerPreviewState({required List<FileModel> filesModel})
      : super(files: filesModel);
}
class FileManagerLoadingState extends FileManagerState {
  const FileManagerLoadingState({required List<FileModel> filesModel})
      : super(files: filesModel);
}
class FileManagerErrorState extends FileManagerState {
  final String errorMessage;
  const FileManagerErrorState({required List<FileModel> filesModel, required this.errorMessage})
      : super(files: filesModel);
}
class FileManagerErrorGettingFilesState extends FileManagerState {
  final String errorMessage;
  const FileManagerErrorGettingFilesState({required List<FileModel> filesModel, required this.errorMessage})
      : super(files: filesModel);
}
class FileManagerAcceptedState extends FileManagerState {
  final String message;
  const FileManagerAcceptedState({required List<FileModel> filesModel, required this.message})
      : super(files: filesModel);
}
