// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/blocs/home/home_bloc.dart';
import 'package:flutter_poc/widgets/app_layout.dart';
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
        if (state is HomeProductItemWishlistedActionState) {
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
            return AppLayout(child: Center(child: CircularProgressIndicator()));
          case HomeLoadedSuccessState:
            return AppLayout(
              child: ListView.builder(
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
            return Center(child: Text('Some Error occured!'));
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
