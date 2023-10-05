part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInUserEvent extends SignInEvent {
  final String cedula;
  final String password;

  const SignInUserEvent({required this.cedula, required this.password});

  @override
  List<Object> get props => [cedula, password];
}

class SignInTestEventLoaded extends SignInEvent {}
