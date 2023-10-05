import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class FileUploadEntity extends Equatable {
  final Uint8List fileBytes;
  final String fileName;

  const FileUploadEntity({
    required this.fileBytes,
    required this.fileName,
  });

  @override
  List<Object?> get props => [fileBytes, fileName];
}
