import 'package:equatable/equatable.dart';

class SignInResponse extends Equatable {
  final String signInToken;

  const SignInResponse({
    required this.signInToken,
  });

  @override
  List<Object?> get props => [signInToken];
}
