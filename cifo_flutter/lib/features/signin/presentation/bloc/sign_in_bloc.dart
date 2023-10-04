
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifo_flutter/features/signin/domain/entities/sign_in_entity.dart';
import 'package:cifo_flutter/features/signin/domain/usecases/sign_in_user.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUser signInUser;

  SignInBloc({required this.signInUser}) : super(SignInInitialState()) {
    on<SignInUserEvent>((event, emit) async {
      emit(SignInLoadingState());
      final failureOrSignIn = await signInUser(
        SignInEntity(email: event.cedula, password: event.password),
      );
      failureOrSignIn.fold((failure) {
        print("Error singin Bloc");
        emit(const SignInErrorState(
          errorMessage: "Error Sign In",
        ));
      }, (authentication) {
        emit(SignedInUserState());
      });
    });
  }
}
