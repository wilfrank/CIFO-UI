part of 'file_uploader_bloc.dart';

abstract class FileUploaderState extends Equatable {
  const FileUploaderState({
    required this.file,
  });
  final FileUploadModel? file;

  @override
  List<dynamic> get props => [file];
}

class FileUploadInitialState extends FileUploaderState {
  const FileUploadInitialState() : super(file: null);
}

class FileUploadLoadingState extends FileUploaderState {
  const FileUploadLoadingState({required FileUploadModel? fileUploadModel})
      : super(file: fileUploadModel);
}

class FileUploadErrorState extends FileUploaderState {
  final String errorMessage;
  const FileUploadErrorState(
      {required FileUploadModel? fileUploadModel, required this.errorMessage})
      : super(file: fileUploadModel);
}

class FileUploadAcceptedState extends FileUploaderState {
  final String message;
  const FileUploadAcceptedState(
      {required FileUploadModel fileUploadModel, required this.message})
      : super(file: fileUploadModel);
}

class FileSelectedState extends FileUploaderState {
  final String fileName;
  final Uint8List fileBytes;
  FileSelectedState({required this.fileBytes, required this.fileName})
      : super(file: FileUploadModel(fileBytes: fileBytes, fileName: fileName));
}
