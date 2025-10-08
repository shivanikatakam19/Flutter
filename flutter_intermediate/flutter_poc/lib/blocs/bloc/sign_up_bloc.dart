import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressedEvent>((event, emit) {
      createUserWithEmailAndPassword(
        event.userDetails['email'] ?? '',
        event.userDetails['password'] ?? '',
        event.userDetails['username'] ?? '',
      );
    });
  }

  Future<Object?> createUserWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(username);
      return credential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors (e.g., weak-password, email-already-in-use)
      return e.code;
    }
  }
}
