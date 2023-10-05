import 'package:cifo_flutter/core/constants/api.dart';
import 'package:cifo_flutter/core/http/custom_http_client.dart';
import 'package:cifo_flutter/features/signin/data/models/sign_in_email_model.dart';
import 'package:cifo_flutter/features/signin/domain/entities/sign_in_entity.dart';
import 'package:dio/dio.dart';

abstract class SignInRemoteDataSource {
  Future<Response> loginUser({required SignInEntity signInEmail});
}

class SignInRemoteDataSourceImpl extends SignInRemoteDataSource {
  final CustomHttpClient client;
  SignInRemoteDataSourceImpl({required this.client});

  @override
  Future<Response> loginUser({required SignInEntity signInEmail}) async {
    // return SignInResponseModel.fromMap(const {'token':'tokenDePrueba'});

    final jsonData = await client.post(
      path: API.apiLogIn,
      body: SignInEmailModel(
        email: signInEmail.email,
        password: signInEmail.password,
      ).toJson(),
    );

    if (jsonData.statusCode == 200) {
      //Used for setting Cedula
      await client.get(
        path: API.apiGetFiles,
      );
    }
    return jsonData;
  }
}
