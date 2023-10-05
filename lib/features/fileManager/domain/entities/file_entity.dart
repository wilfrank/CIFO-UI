import 'package:equatable/equatable.dart';

class FileEntity extends Equatable {
  final String label;
  final String name;
  final String url;
  final bool isVerified;

  const FileEntity({
    required this.label,
    required this.name,
    required this.url,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [label,name, url, isVerified];
}
