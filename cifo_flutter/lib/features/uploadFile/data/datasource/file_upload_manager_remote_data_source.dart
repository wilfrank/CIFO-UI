import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';
import 'package:cifo_flutter/features/uploadFile/domain/entities/file_upload_entity.dart';

import 'package:cifo_flutter/core/constants/api.dart';
import 'package:cifo_flutter/core/http/custom_http_client.dart';

abstract class FileUploadManagerRemoteDataSource {
  Future<Response> uploadFile(FileUploadEntity fileUploadEntity);
}

class FileUploadManagerRemoteDataSourceImpl
    implements FileUploadManagerRemoteDataSource {
  final CustomHttpClient client;
  final SecureStorage secureStorage;

  FileUploadManagerRemoteDataSourceImpl({
    required this.client,
    required this.secureStorage,
  });

  @override
  Future<Response> uploadFile(FileUploadEntity fileUploadEntity) async {
    int cedula = int.parse(secureStorage.getCedula());
    Uint8List fileBytes = fileUploadEntity.fileBytes;
    // String imageString = base64.encode(utf8.encode(fileBytes.toString()));
    String imageString = base64Encode(fileBytes);
    // imageString.
    final jsonData = await client.post(path: API.apiUploadFile, body: {
      "ContentType": "application/pdf",
      "Name": fileUploadEntity.fileName,
      "DocumentRouting": "",
      "UserId": cedula,
      "imageString": imageString,
    });
    // Response jsonData = Response(requestOptions: RequestOptions());
    return jsonData;
  }
}
