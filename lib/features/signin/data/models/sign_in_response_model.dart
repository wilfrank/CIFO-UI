import 'dart:convert';

import 'package:cifo_flutter/features/signin/domain/entities/sign_in_response.dart';

class SignInResponseModel extends SignInResponse {
  const SignInResponseModel({
    required String signInToken,
  }) : super(signInToken: signInToken);

  factory SignInResponseModel.fromJson(String str) =>
      SignInResponseModel.fromMap(
        json.decode(str),
      );

  String toJson() => json.encode(toMap());

  factory SignInResponseModel.fromMap(Map<String, dynamic> json) =>
      SignInResponseModel(
        signInToken: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": signInToken,
      };
}
