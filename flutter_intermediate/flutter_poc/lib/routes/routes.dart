import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/cart_ui.dart';
import 'package:flutter_poc/screens/home_ui.dart';
import 'package:flutter_poc/screens/image_picker.dart';
import 'package:flutter_poc/screens/location.dart';
import 'package:flutter_poc/screens/login_ui.dart';
import 'package:flutter_poc/screens/map_ui.dart';
import 'package:flutter_poc/screens/platform-specific-code.dart';
import 'package:flutter_poc/screens/sign-up_ui.dart';
import 'package:flutter_poc/screens/todo_ui.dart';
import 'package:flutter_poc/screens/wishlist_ui.dart';

class AppRoutes {
  // Define route names as constants
  static const String home = '/home';
  static const String wishlist = '/details';
  static const String cart = '/cart';
  static const String todo = '/todo';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String camera = '/camera';
  static const String location = '/location';
  static const String map = '/maps';
  static const String battery = '/battery';

  // Generate routes here
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginForm());

      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpForm());

      case home:
        return MaterialPageRoute(builder: (_) => const Home());

      case wishlist:
        return MaterialPageRoute(builder: (_) => const Wishlist());

      case cart:
        return MaterialPageRoute(builder: (_) => const Cart());

      case todo:
        return MaterialPageRoute(builder: (_) => const Todo());

      case camera:
        return MaterialPageRoute(builder: (_) => const ImagePick());

      case location:
        return MaterialPageRoute(builder: (_) => const LocationUI());

      case map:
        return MaterialPageRoute(builder: (_) => const MapUi());

      case battery:
        return MaterialPageRoute(builder: (_) => const BatteryPercentage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
