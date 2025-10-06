// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/screens/home/bloc/home_bloc.dart';
import 'package:flutter_poc/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_poc/widgets/product_tile.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistLoadingState:
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            case WishlistLoadedSuccessState:
              return ListView.builder(
                itemCount:
                    (state as WishlistLoadedSuccessState).wishlistItems.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    grocery: (state).wishlistItems[index],
                    homeBloc: HomeBloc(),
                  );
                },
              );
            case WishlistErrorState():
              return Center(child: Text("Some error occurred!"));
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
