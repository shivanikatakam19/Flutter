import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SubmitButtonPressedEvent>((event, emit) async {
      final credential = await signInWithEmailAndPassword(
        event.userDetails['email'] ?? '',
        event.userDetails['password'] ?? '',
      );
      if (credential is UserCredential) {
        await saveUserToLocal(FirebaseAuth.instance.currentUser!);
        emit(LoginAuthenticatedState());
      } else {
        emit(LoginUnauthenticatedState(credential.toString()));
      }
    });

    on<NavigateToSignInPageEvent>((event, emit) {
      emit(NavigateToSignInPageActionState());
    });
  }

  Future<Object?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors (e.g., weak-password, email-already-in-use)
      switch (e.code) {
        case 'wrong-password':
          return 'Incorrect password provided.';
        case 'user-not-found':
          return 'No user found for that email.';
        case 'invalid-email':
          return 'The email address is invalid.';
        case 'too-many-requests':
          return 'Too many login attempts. Try again later.';
        case 'invalid-credential':
          return 'Invalid credentials. Please check your email and password.';
        default:
          return 'Authentication failed. Please try again.';
      }
    }
  }

  Future<void> saveUserToLocal(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', user.uid);
    await prefs.setString('email', user.email ?? '');
    await prefs.setString('displayName', user.displayName ?? '');
  }
}
