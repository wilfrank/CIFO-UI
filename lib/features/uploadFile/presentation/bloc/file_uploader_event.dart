part of 'file_uploader_bloc.dart';

abstract class FileUploaderEvent extends Equatable {
  final FileUploadModel? file;
  const FileUploaderEvent({required this.file});
  @override
  List<dynamic> get props => [file];
}

class FileManagerInitializeEvent extends FileUploaderEvent {
  const FileManagerInitializeEvent({required FileUploadModel fileUploadModel})
      : super(file: fileUploadModel);
}

class UploadFileEvent extends FileUploaderEvent {
  const UploadFileEvent({required FileUploadModel fileUploadModel})
      : super(file: fileUploadModel);
}
class UploadErrorFileEvent extends FileUploaderEvent {
  const UploadErrorFileEvent()
      : super(file: null);
}

class SelectFileEvent extends FileUploaderEvent {
  final String fileName;
  final Uint8List fileBytes;
  SelectFileEvent({required this.fileBytes, required this.fileName})
      : super(file: FileUploadModel(fileBytes: fileBytes, fileName: fileName));
}