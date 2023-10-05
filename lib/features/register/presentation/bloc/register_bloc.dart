import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifo_flutter/core/constants/constants.dart';
import 'package:cifo_flutter/core/errors/failures.dart';
import 'package:cifo_flutter/features/register/domain/entities/register_params.dart';
import 'package:cifo_flutter/features/register/domain/usecases/register_user.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser registerUser;

  RegisterBloc({required this.registerUser}) : super(RegisterInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      final failureOrSignIn = await registerUser(
        RegisterParams(
            phoneNumber: event.phoneNumber,
            surname: event.surname,
            name: event.name,
            address: event.address,
            email: event.email,
            password: event.password,
            id: event.id),
      );
      failureOrSignIn.fold((failure) {
        if (failure is ServerFailure) {
          emit(const RegisterErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (register) {
        emit(RegisterCompletedState());
        emit(RegisterInitialState());
      });
    });
  }
}
