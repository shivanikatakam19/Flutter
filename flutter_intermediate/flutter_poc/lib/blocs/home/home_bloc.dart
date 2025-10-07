import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/data/cart_items.dart';
import 'package:flutter_poc/data/grocery_list.dart';
import 'package:flutter_poc/data/wishlist_items.dart';
import 'package:flutter_poc/models/grocery.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoadingState());
      await Future.delayed(Duration(seconds: 2), () {
        emit(HomeLoadedSuccessState(groceries: groceries));
      });
    });

    on<HomeProductWishlistButtonPressedEvent>((event, emit) {
      if (!wishlistItems.contains(event.wishlistProduct)) {
        event.wishlistProduct.isAddedToWishlist = true;
        wishlistItems.add(event.wishlistProduct);
        emit(HomeProductItemWishlistedActionState());
      } else {
        return;
      }
    });

    on<HomeProductCartButtonPressedEvent>((event, emit) {
      if (!cartItems.contains(event.cartProduct)) {
        event.cartProduct.isAddedToCart = true;
        cartItems.add(event.cartProduct);
        emit(HomeProductItemCartActionState());
      } else {
        return;
      }
    });

    on<HomeWishlistButtonNavigateEvent>((event, emit) {
      emit(HomeNavigateToWishlistPageActionState());
    });

    on<HomeCartButtonNavigateEvent>((event, emit) {
      emit(HomeNavigatetoCartPageActionState());
    });

    on<HomeTodoButtonNavigateEvent>((event, emit) {
      emit(HomeNavigateToTodoPageActionState());
    });
  }
}
