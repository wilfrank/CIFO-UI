import 'package:cifo_flutter/features/home/domain/entities/transfer_params.dart';
import 'package:cifo_flutter/features/home/domain/usecases/transfer_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cifo_flutter/core/constants/constants.dart';
import 'package:cifo_flutter/core/errors/failures.dart';


part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferUser transferUser;

  TransferBloc({required this.transferUser}) : super(TransferInitialState()) {
    on<TransferUserEvent>((event, emit) async {
      emit(TransferLoadingState());
      final failureOrSignIn = await transferUser(
        TransferParams(
          transferID: event.transferID,
        ),
      );
      failureOrSignIn.fold((failure) {
        if (failure is ServerFailure) {
          emit(const TransferErrorState(
            errorMessage: Constants.serverFailureMessage,
          ));
        }
      }, (transfer) {
        emit(TransferCompletedState());
        emit(TransferInitialState());
      });
    });
  }
}
