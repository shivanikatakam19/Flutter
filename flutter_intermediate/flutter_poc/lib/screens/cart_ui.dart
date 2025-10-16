// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/blocs/cart/cart_bloc.dart';
import 'package:flutter_poc/blocs/home/home_bloc.dart';
import 'package:flutter_poc/widgets/product_tile.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingState:
              return Center(child: CircularProgressIndicator());
            case CartLoadedSuccessState:
              return ListView.builder(
                itemCount: (state as CartLoadedSuccessState).cartItems.length,
                itemBuilder: (context, index) {
                  return ProductTile(
                    grocery: (state).cartItems[index],
                    homeBloc: HomeBloc(),
                  );
                },
              );
            case CartErrorState():
              return Center(child: Text("Some error occurred!"));
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
