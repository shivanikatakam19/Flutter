part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpButtonPressedEvent extends SignUpEvent {
  final Map<String, String> userDetails;

  SignUpButtonPressedEvent({required this.userDetails});
}

class NavigateToLoginPageEvent extends SignUpEvent {}

class SignedInEvent extends SignUpEvent {}
