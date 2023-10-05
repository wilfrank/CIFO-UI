import 'dart:convert';

import 'package:cifo_flutter/features/signin/domain/entities/sign_in_entity.dart';

class SignInEmailModel extends SignInEntity {
  const SignInEmailModel({required String email, required String password})
      : super(email: email, password: password);

  Map<String, dynamic> toMap() {
    return {"id": "", "userName": "", "email": email, "password": password};
  }

  String toJson() => jsonEncode(toMap());
}
