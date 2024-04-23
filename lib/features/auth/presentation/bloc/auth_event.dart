part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {}
