part of 'auth_cubit.dart';

@immutable
sealed class AuthState  extends Equatable{}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoaded extends AuthState{
  final Auth auth;

  AuthLoaded(this.auth);
  @override
  List<Object?> get props => [auth];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}