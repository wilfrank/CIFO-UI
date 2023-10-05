import 'package:equatable/equatable.dart';

class TransferParams extends Equatable {
  final int transferID;
  const TransferParams({
    required this.transferID,
  });

  @override
  List<Object> get props => [transferID];
}
