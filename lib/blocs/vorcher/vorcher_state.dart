part of 'vorcher_cubit.dart';

@immutable
sealed class VorcherState extends Equatable{}

final class VorcherInitial extends VorcherState {
  @override
  List<Object?> get props => [];
}

final class VorcherLoaded extends VorcherState{
  final List<Vorcher> vorcher;
  VorcherLoaded(this.vorcher);
  @override
  List<Object?> get props => [vorcher];
}

final class VorcherError extends VorcherState{
  final String error;
  VorcherError(this.error);
  @override
  List<Object?> get props => [error];
}