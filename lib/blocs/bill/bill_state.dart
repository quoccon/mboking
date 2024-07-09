part of 'bill_cubit.dart';

@immutable
sealed class BillState extends Equatable{}

final class BillInitial extends BillState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class BillSuccess extends BillState {
  final Bill bill;
  BillSuccess(this.bill);
  @override
  List<Object?> get props => [bill];
}

final class BillError extends BillState{
  final String error;

  BillError(this.error);
  @override
  List<Object?> get props => [error];
}
