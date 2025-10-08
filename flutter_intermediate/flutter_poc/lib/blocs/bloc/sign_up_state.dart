part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpActionState extends SignUpState {}

class SignUpAuthenticatedState extends SignUpActionState {}

class SignUpUnauthenticatedState extends SignUpActionState {}

class NavigateToLoginPageActionState extends SignUpActionState {}
