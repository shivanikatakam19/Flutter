import 'package:flutter/material.dart';
import 'package:flutter_poc/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('uid'); // true if user details exist
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          // User is logged in → navigate to Home
          // Using pushReplacement to avoid back button to RootScreen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          });

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          // User not logged in → navigate to Login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
