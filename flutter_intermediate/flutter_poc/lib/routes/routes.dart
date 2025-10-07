import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/cart_ui.dart';
import 'package:flutter_poc/screens/home_ui.dart';
import 'package:flutter_poc/screens/login/ui/login_ui.dart';
import 'package:flutter_poc/screens/todo_ui.dart';
import 'package:flutter_poc/screens/wishlist_ui.dart';

class AppRoutes {
  // Define route names as constants
  static const String home = '/home';
  static const String wishlist = '/details';
  static const String cart = '/cart';
  static const String todo = '/todo';
  static const String login = '/login';

  // Generate routes here
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginForm());

      case home:
        return MaterialPageRoute(builder: (_) => const Home());

      case wishlist:
        return MaterialPageRoute(builder: (_) => const Wishlist());

      case cart:
        return MaterialPageRoute(builder: (_) => const Cart());

      case todo:
        return MaterialPageRoute(builder: (_) => const Todo());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
