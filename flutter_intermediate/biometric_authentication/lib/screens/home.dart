import 'package:biometric_authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the homepage'),

            //log out button
            ElevatedButton(
              onPressed: () async {
                final Future<SharedPreferences> prefs =
                    SharedPreferences.getInstance();
                prefs.then((SharedPreferences prefs) {
                  prefs.setBool('isloggedin', false);
                  prefs.setBool('isbiometricenabled', false);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Logout'),
            ),
            //setup authentication button
          ],
        ),
      ),
    );
  }
}
