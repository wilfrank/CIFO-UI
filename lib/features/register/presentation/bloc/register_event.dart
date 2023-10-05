part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String name;
  final String surname;
  final String address;
  final String email;
  final String password;
  final String id;
  final String phoneNumber;

  const RegisterUserEvent({
    required this.name,
    required this.surname,
    required this.address,
    required this.email,
    required this.password,
    required this.id,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [name, address, email, password, id, surname,phoneNumber];
}
