part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginActionState extends LoginState {}

class LoginAuthenticatedState extends LoginActionState {}

class LoginUnauthenticatedState extends LoginActionState {
  final String errorMessage;
  LoginUnauthenticatedState(this.errorMessage);
}

class NavigateToSignInPageActionState extends LoginActionState {}
