import 'dart:convert';

import 'package:cifo_flutter/features/fileManager/data/models/file_model.dart';
import 'package:cifo_flutter/features/fileManager/domain/entities/files_response.dart';

class FilesResponseModel extends FilesResponse {
  const FilesResponseModel({required Map<String, dynamic> filesResponse})
      : super(filesResponse: filesResponse);

  factory FilesResponseModel.fromJson(String str) => FilesResponseModel.fromMap(
        json.decode(str),
      );

  String toJson() => json.encode(toMap());

  factory FilesResponseModel.fromMap(Map<String, dynamic> json) =>
      FilesResponseModel(
        filesResponse: json["results"],
      );

  static List<FileModel> fromSet(dynamic jsonSet) {
    // Set<Map<String, dynamic>> results = jsonSet["documents"];
    List<dynamic> results = jsonSet["documents"];

    List<FileModel> list = List.empty(growable: true);
    for (var element in results) {
      list.add(FileModel.fromMap(element));
    }
    return list;
  }

  Map<String, dynamic> toMap() => {
        "results": filesResponse,
      };
}
