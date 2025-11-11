import 'package:biometric_authentication/screens/home.dart';
import 'package:biometric_authentication/services/biometric_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showbiometric = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

    prefs.then((SharedPreferences prefs) {
      bool isloggedin = prefs.getBool('isloggedin') ?? false;
      bool isbiometricenabled = prefs.getBool('isbiometricenabled') ?? false;

      if (isloggedin && isbiometricenabled) {
        setState(() {
          showbiometric = true;
        });
      } else {
        setState(() {
          showbiometric = false;
        });
      }
    });
  }

  void _loginuser() async {
    // add your own logic of authentication here
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

    await prefs.then((SharedPreferences prefs) {
      prefs.setBool('isloggedin', true);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              _loginuser();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text('Sign In'),
                          ),
                        ),
                        !showbiometric
                            ? ElevatedButton(
                                onPressed: () async {
                                  Biometricauth().checkBiometric(
                                    context,
                                    LoginScreen(),
                                    LoginScreen(),
                                    true,
                                  );
                                },
                                child: Text('Setup Authentication'),
                              )
                            : GestureDetector(
                                onTap: () => Biometricauth().checkBiometric(
                                  context,
                                  HomeScreen(),
                                  LoginScreen(),
                                  false,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.fingerprint),
                                    const SizedBox(width: 10),
                                    const Text('Tap to login with biometric'),
                                  ],
                                ),
                              ),

                        //Biometric option
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
