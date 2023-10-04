import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cifo_flutter/core/constants/constants.dart';
import 'package:cifo_flutter/features/uploadFile/data/models/file_upload_model.dart';
import 'package:cifo_flutter/features/uploadFile/domain/usecase/upload_file.dart';

part 'file_uploader_event.dart';
part 'file_uploader_state.dart';

class FileUploaderBloc extends Bloc<FileUploaderEvent, FileUploaderState> {
  final UploadFileUseCase uploadFileUseCase;

  FileUploaderBloc({
    required this.uploadFileUseCase,
  }) : super(const FileUploadInitialState()) {
    on<UploadFileEvent>((event, emit) async {
      emit(const FileUploadLoadingState(fileUploadModel: null));

      final failureOrAccepted = await uploadFileUseCase(event.file!);

      failureOrAccepted.fold((error) {
        emit(FileUploadErrorState(
            fileUploadModel: event.file!, errorMessage: Constants.errorUpload));
      }, (accepted) {
        emit(FileUploadAcceptedState(
            fileUploadModel: event.file!, message: Constants.acceptedUpload));
            emit(const FileUploadInitialState());
      });
    });

    on<SelectFileEvent>((event, emit) async {
      emit(FileSelectedState(
          fileBytes: event.fileBytes, fileName: event.fileName));
    });

    on<UploadErrorFileEvent>((event, emit) async {
      emit(const FileUploadErrorState(
          fileUploadModel: null, errorMessage: Constants.errorSelectUpload));
    });
  }
}
