part of 'transfer_bloc.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitialState extends TransferState {}

class TransferLoadingState extends TransferState {}

class TransferCompletedState extends TransferState {}

class TransferErrorState extends TransferState {
  final String errorMessage;

  const TransferErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
