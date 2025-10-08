part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class SubmitButtonPressedEvent extends LoginEvent {
  final Map<String, String> userDetails;

  SubmitButtonPressedEvent({required this.userDetails});
}

class NavigateToSignInPageEvent extends LoginEvent {}
