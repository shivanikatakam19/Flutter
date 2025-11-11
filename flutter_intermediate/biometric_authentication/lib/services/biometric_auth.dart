import 'package:local_auth/local_auth.dart  ';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Biometricauth {
  final auth = LocalAuthentication();

  Future<void> checkBiometric(
    context,
    Widget successcreen,
    Widget failscreen,
    bool? issetup,
  ) async {
    bool canCheckBiometric = await auth.canCheckBiometrics;

    if (canCheckBiometric) {
      List<BiometricType> availableBiometric = await auth
          .getAvailableBiometrics();

      if (availableBiometric.isNotEmpty) {
        bool authenticated = await auth.authenticate(
          localizedReason: "Scan your finger to authenticate",
        );

        if (authenticated) {
          if (issetup == true) {
            final Future<SharedPreferences> prefs =
                SharedPreferences.getInstance();
            prefs.then((SharedPreferences prefs) {
              prefs.setBool('isbiometricenabled', true);
            });
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => successcreen),
            (Route<dynamic> route) => false, // removes all previous routes
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => failscreen),
            (Route<dynamic> route) => false, // removes all previous routes
          );
        }
      } else {
        print("No biometric available");
      }
    } else {
      print("Your device does not support biometric authentication");
    }
  }
}
