import 'dart:convert';

import 'package:cifo_flutter/features/register/domain/entities/register_params.dart';

class RegisterParamsModel extends RegisterParams {
  const RegisterParamsModel({
    required String name,
    required String surname,
    required String email,
    required String cedula,
    required String password,
    required String phoneNumber,
    required String address,
  }) : super(
          phoneNumber: phoneNumber,
          surname: surname,
          name: name,
          address: address,
          email: email,
          password: password,
          id: cedula,
        );

  Map<String, dynamic> toMap() {
    return {
      "id": "",
      "userName": "",
      "email": email,
      "password": password,
      "firstName": name,
      "lastName": address,
      "identityType": "CC",
      "identityNumber": id,
      "phoneNumber": phoneNumber,
      "address": address,
      "IsActived": true,
      "documents": null
    };
  }

  String toJson() => jsonEncode(toMap());
}
