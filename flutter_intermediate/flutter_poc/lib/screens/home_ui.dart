// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/routes/routes.dart';
import 'package:flutter_poc/blocs/home/home_bloc.dart';
import 'package:flutter_poc/widgets/product_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => (current is! HomeActionState),
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.pushNamed(context, AppRoutes.wishlist);
        } else if (state is HomeNavigatetoCartPageActionState) {
          Navigator.pushNamed(context, AppRoutes.cart);
        } else if (state is HomeNavigateToTodoPageActionState) {
          Navigator.pushNamed(context, AppRoutes.todo);
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Item added to wishlist!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is HomeProductItemCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Item added to cart!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case HomeLoadedSuccessState:
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Grocery App',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeTodoButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.assignment_outlined),
                  ),
                ],
                backgroundColor: Colors.teal,
              ),
              body: ListView.builder(
                itemCount: (state as HomeLoadedSuccessState).groceries.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    grocery: (state).groceries[index],
                    homeBloc: homeBloc,
                  );
                },
              ),
            );
          case HomeErrorState:
            return Scaffold(body: Center(child: Text('Some Error occured!')));
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
