part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState{}
class AuthLoaded extends AuthState{}
class LoggedIn extends AuthState{}

class ResetCodeSent extends AuthState{}

class AuthError extends AuthState{
  final String message;
  const AuthError(this.message);
}