import 'package:flutter/material.dart';
import 'package:flutter_poc/screens/cart/ui/cart_ui.dart';
import 'package:flutter_poc/screens/home/ui/home_ui.dart';
import 'package:flutter_poc/screens/todos/ui/todo_ui.dart';
import 'package:flutter_poc/screens/wishlist/ui/wishlist_ui.dart';

class AppRoutes {
  // Define route names as constants
  static const String home = '/';
  static const String wishlist = '/details';
  static const String cart = '/cart';
  static const String todo = '/todo';

  // Generate routes here
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
