import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cifo_flutter/features/uploadFile/presentation/bloc/file_uploader_bloc.dart';

class UploadFileScreen extends StatelessWidget {
  const UploadFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FileUploaderBloc fileUploaderBloc =
    //     InjectionContainerImpl().sl.get<FileUploaderBloc>();

    return BlocConsumer<FileUploaderBloc, FileUploaderState>(
      listener: (context, state) {
        if (state is FileUploadLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                content: Center(
                  child: CircularProgressIndicator(),
                ),
                surfaceTintColor: Colors.transparent,
              );
            },
          );
        } else if (state is FileUploadErrorState) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Hubo un error'),
                  content: Text(state.errorMessage),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); //Pop Error
                        Navigator.pop(context); //Pop Loading
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                );
              });
        } else if (state is FileUploadAcceptedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              width: 200,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(state.message),
            ),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is FileUploadInitialState ||
            state is FileSelectedState ||
            state is FileUploadAcceptedState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('File Upload CiFo'),
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (state.file != null)
                    const Icon(
                      Icons.file_present,
                      size: 150,
                      color: Colors.grey,
                    )
                  else
                    const Icon(
                      Icons.upload_file,
                      size: 150,
                      color: Colors.grey,
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowMultiple: false,
                          dialogTitle: 'Archivo a Subir',
                          allowedExtensions: ['pdf']);

                      if (result != null && result.files.isNotEmpty) {
                        final fileBytes = result.files.first.bytes;
                        final fileName = result.files.first.name;
                        if (fileBytes != null) {
                          context.read<FileUploaderBloc>().add(SelectFileEvent(
                              fileBytes: fileBytes, fileName: fileName));
                        }
                      } else {
                        context
                            .read<FileUploaderBloc>()
                            .add(const UploadErrorFileEvent());
                      }
                    },
                    child: const Text('Seleccionar archivo'),
                  ),
                  const SizedBox(height: 20),
                  if (state.file != null)
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<FileUploaderBloc>()
                            .add(UploadFileEvent(fileUploadModel: state.file!));
                      },
                      child: const Text('Subir archivo'),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    state.file == null
                        ? 'No se ha seleccionado ningún archivo'
                        : 'Archivo seleccionado: ${state.file!.fileName}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
