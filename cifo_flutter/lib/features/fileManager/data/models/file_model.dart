import 'dart:convert';

import 'package:cifo_flutter/features/fileManager/domain/entities/file_entity.dart';

class FileModel extends FileEntity {
  const FileModel(
      {required String label,
      required String name,
      required String url,
      required bool isVerified})
      : super(
          label: label,
          name: name,
          url: url,
          isVerified: isVerified
        );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": label,
        "fileName": name,
      };

  factory FileModel.fromMap(Map<String, dynamic> json) {
    return FileModel(
      label: json["label"],
      name: json["name"],
      url: json["url"],
      isVerified: json["isVerified"]
    );
  }
}
