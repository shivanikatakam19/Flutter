import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  final _formGlobalKey = GlobalKey<FormState>();
  String _username = '';
  String _useremail = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  // Every widget must implement the build method
  // build describes what the UI looks like for the current state.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              // username
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Username is required'
                      : null;
                },
                onSaved: (newValue) => {_username = newValue!},
              ),

              SizedBox(height: 20),

              // email
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
                      'username': _username,
                      'email': _useremail,
                      'password': _password,
                    });
                    _formGlobalKey.currentState?.reset();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // <-- Text color
                  backgroundColor: Colors.teal, // <-- Button background color
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
