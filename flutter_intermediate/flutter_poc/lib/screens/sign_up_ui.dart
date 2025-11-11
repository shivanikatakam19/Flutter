import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/blocs/bloc/sign_up_bloc.dart';
import 'package:flutter_poc/routes/routes.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpBloc signUpBloc = SignUpBloc();
  final _formGlobalKey = GlobalKey<FormState>();
  String _useremail = '';
  String _password = '';
  String _username = '';
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      bloc: signUpBloc,
      listener: (context, state) {
        if (state is SignUpAuthenticatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signed up successfully. Log in to continue.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushNamed(context, AppRoutes.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Sign Up'),
            centerTitle: true,
            backgroundColor: Colors.teal,
          ),
          body: Form(
            key: _formGlobalKey,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20),

                  // email
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }

                      return null;
                    },
                    onSaved: (newValue) => {_username = newValue!},
                  ),

                  SizedBox(height: 20),
                  // password
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      const pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      final regex = RegExp(pattern);

                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    onSaved: (newValue) => {_useremail = newValue!},
                  ),

                  SizedBox(height: 20),

                  // password
                  TextFormField(
                    maxLength: 8,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? 'Password is required'
                          : value.length < 8
                          ? 'Password must be at least 8 characters'
                          : null;
                    },
                    onSaved: (newValue) => {_password = newValue!},
                  ),

                  // submit button
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {
                        _formGlobalKey.currentState!.save();
                        Navigator.pop(context, {
                          'email': _useremail,
                          'password': _password,
                          'username': _username,
                        });
                        signUpBloc.add(
                          SignUpButtonPressedEvent(
                            userDetails: {
                              'email': _useremail,
                              'password': _password,
                              'username': _username,
                            },
                          ),
                        );
                        _formGlobalKey.currentState?.reset();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // <-- Text color
                      backgroundColor:
                          Colors.teal, // <-- Button background color
                    ),
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 50),

                  // hyper-link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to another route
                          signUpBloc.add(NavigateToLoginPageEvent());
                        },
                        child: const Text(
                          "Already have an account? Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration
                                .underline, // makes it look like a link
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
