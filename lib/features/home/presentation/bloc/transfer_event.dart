part of 'transfer_bloc.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class TransferUserEvent extends TransferEvent {
  final int transferID;

  const TransferUserEvent({
    required this.transferID,
  });

  @override
  List<Object> get props => [transferID];
}
