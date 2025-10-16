import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/blocs/home/home_bloc.dart';
import 'package:flutter_poc/routes/routes.dart';

class AppLayout extends StatefulWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout>
    with SingleTickerProviderStateMixin {
  HomeBloc homeBloc = HomeBloc();
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  bool _isSidebarVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // start off-screen to the left
      end: Offset.zero, // slides in
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
      if (_isSidebarVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // intercept back button: close sidebar if visible
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => (current is! HomeActionState),
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.pushNamed(context, AppRoutes.wishlist);
        } else if (state is HomeNavigatetoCartPageActionState) {
          Navigator.pushNamed(context, AppRoutes.cart);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.person_outlined),
                  onPressed: toggleSidebar,
                ),
                Text(
                  'Grocery App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                onPressed: () {
                  homeBloc.add(HomeWishlistButtonNavigateEvent());
                },
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  homeBloc.add(HomeCartButtonNavigateEvent());
                },
              ),
            ],
            backgroundColor: Colors.teal,
          ),

          body: Stack(
            children: [
              // Main column with fixed top app bar and content below
              Column(children: [Expanded(child: widget.child)]),

              if (_isSidebarVisible)
                GestureDetector(
                  onTap: toggleSidebar,
                  child: Container(color: Colors.black54),
                ),

              // Sidebar (slides from right)
              SlideTransition(
                position: _slideAnimation,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 240,
                    color: Colors.blueGrey[900],
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        _menuItem(Icons.home_outlined, 'Home', AppRoutes.home),
                        _menuItem(
                          Icons.assignment_outlined,
                          'Todo list with dio',
                          AppRoutes.todo,
                        ),
                        _menuItem(
                          Icons.camera_outlined,
                          'Image Picker',
                          AppRoutes.camera,
                        ),
                        _menuItem(
                          Icons.location_on_outlined,
                          'Get Current Location',
                          AppRoutes.location,
                        ),
                        _menuItem(Icons.map_outlined, 'Maps', AppRoutes.map),
                        _menuItem(
                          Icons.battery_std_outlined,
                          'Battery Percentage',
                          AppRoutes.battery,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _menuItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () => _navigateTo(route),
    );
  }

  void _navigateTo(String route) {
    Navigator.of(context).pushReplacementNamed(route);
    toggleSidebar();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
