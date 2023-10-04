// import 'dart:convert';

// import 'package:jwt_decoder/jwt_decoder.dart';

// import 'package:poker_planning/features/signin/domain/entities/sign_in_token_payload.dart';

// class SignInTokenPayloadModel extends SignInTokenPayload {
//   SignInTokenPayloadModel({
//     required String name,
//     required String lastName,
//     required String email,
//     required String photo,
//     required String userGuid,
//     required int exp,
//   }) : super(
//           name: name,
//           lastName: lastName,
//           email: email,
//           photo: photo,
//           userGuid: userGuid,
//           exp: exp,
//         );

//   factory SignInTokenPayloadModel.fromJson(String str) =>
//       SignInTokenPayloadModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory SignInTokenPayloadModel.fromMap(Map<String, dynamic> json) =>
//       SignInTokenPayloadModel(
//         name: json["name"],
//         lastName: json["lastName"],
//         email: json["email"],
//         photo: json["photo"] ?? '',
//         userGuid: json["userGuid"],
//         exp: json["exp"],
//       );

//   factory SignInTokenPayloadModel.fromToken(String token) {
//     var decodedToken = JwtDecoder.decode(token);
//     return SignInTokenPayloadModel(
//       name: decodedToken["name"],
//       lastName: decodedToken["lastName"],
//       email: decodedToken["email"],
//       photo: decodedToken["photo"] ?? '',
//       userGuid: decodedToken["userGuid"],
//       exp: decodedToken["exp"],
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         "name": name,
//         "lastName": lastName,
//         "email": email,
//         "photo": photo,
//         "userGuid": userGuid,
//         "exp": exp,
//       };
// }
