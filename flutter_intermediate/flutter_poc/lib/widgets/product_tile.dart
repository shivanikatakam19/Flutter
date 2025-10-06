import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poc/models/grocery.dart';
import 'package:flutter_poc/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter_poc/screens/home/bloc/home_bloc.dart';
import 'package:flutter_poc/screens/wishlist/bloc/wishlist_bloc.dart';

class ProductTile extends StatelessWidget {
  final HomeBloc homeBloc;
  static CartBloc cartBloc = CartBloc();
  static WishlistBloc wishlistBloc = WishlistBloc();

  final Grocery grocery;
  const ProductTile({super.key, required this.grocery, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomeActionState,
      listenWhen: (previous, current) => current is HomeActionState,
      listener: (context, state) {
        if (state is RemoveFromCartState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Item removed from cart!"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is RemoveFromWishlistState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Item removed from wishlist!"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(grocery.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Text(
                  grocery.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Text(grocery.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs. ${grocery.price.toString()}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: grocery.isAddedToWishlist
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border_outlined),
                        onPressed: () {
                          if (!grocery.isAddedToWishlist) {
                            homeBloc.add(
                              HomeProductWishlistButtonPressedEvent(
                                wishlistProduct: grocery,
                              ),
                            );
                          } else {
                            wishlistBloc.add(
                              RemoveFromWishlistEvent(grocery: grocery),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: grocery.isAddedToCart
                            ? const Icon(Icons.add_shopping_cart)
                            : const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          if (!grocery.isAddedToCart) {
                            homeBloc.add(
                              HomeProductCartButtonPressedEvent(
                                cartProduct: grocery,
                              ),
                            );
                          } else {
                            cartBloc.add(RemoveFromCartEvent(grocery: grocery));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
