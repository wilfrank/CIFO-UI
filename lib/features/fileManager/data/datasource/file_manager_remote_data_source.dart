import 'package:dio/dio.dart';

import 'package:cifo_flutter/core/errors/exceptions.dart';
import 'package:cifo_flutter/core/secure_storage/secure_storage.dart';
import 'package:cifo_flutter/core/constants/api.dart';
import 'package:cifo_flutter/core/http/custom_http_client.dart';
import 'package:cifo_flutter/features/fileManager/data/models/file_model.dart';
import 'package:cifo_flutter/features/fileManager/data/models/files_response_model.dart';

abstract class FileManagerRemoteDataSource {
  Future<List<FileModel>> getFiles();
  Future<Response> deleteFile(FileModel fileModel);
  Future<Response> authenticateFile(FileModel fileModel);
}

class FileManagerRemoteDataSourceImpl implements FileManagerRemoteDataSource {
  final CustomHttpClient client;
  final SecureStorage secureStorage;

  FileManagerRemoteDataSourceImpl({
    required this.client,
    required this.secureStorage,
  });

  @override
  Future<List<FileModel>> getFiles() async {
    final jsonData = await client.get(
      path: API.apiGetFiles,
    );

    // final Map<String, dynamic> jsonData = {
    //   "documents": {
    //     {
    //       "label": "1",
    //       "name": "GoogleDoc",
    //       "url": "https://www.google.com/",
    //       "isVerified": true
    //     },
    //     {
    //       "label": "2",
    //       "name": "YoutubeDoc",
    //       "url": "https://www.youtube.com/",
    //       "isVerified": true
    //     },
    //     {
    //       "label": "3",
    //       "name": "FacebookDoc",
    //       "url": "https://www.facebook.com/",
    //       "isVerified": false
    //     },
    //   }
    // };

    try {
      List<FileModel> files = FilesResponseModel.fromSet(jsonData.data);
      return files;
    } catch (e) {
      throw ServerException(errorCode: 502, message: 'Bad Response');
    }
  }

  @override
  Future<Response> authenticateFile(FileModel fileModel) async {
    print("Before Post");

    int cedula = int.parse(secureStorage.getCedula());
    final jsonData = await client.put(path: API.apiAuthFile, body: {
      "idCitizen": cedula,
      "urlDocument": fileModel.url,
      "documentTitle": fileModel.label,
    });
    return jsonData;
  }

  @override
  Future<Response> deleteFile(FileModel fileModel) async {
    final jsonData = await client.delete(path: API.apiDeleteFile, body: {
      "name": fileModel.name,
      "label": fileModel.label,
      "url": fileModel.url,
      "isVerified": fileModel.isVerified,
    });
    return jsonData;
  }
}
