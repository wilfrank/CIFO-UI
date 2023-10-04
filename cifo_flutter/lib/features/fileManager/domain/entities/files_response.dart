import 'package:equatable/equatable.dart';

class FilesResponse extends Equatable {
  final Map<String, dynamic> filesResponse;
  const FilesResponse({
    required this.filesResponse,
  });

  @override
  List<Object?> get props => [filesResponse];
}
