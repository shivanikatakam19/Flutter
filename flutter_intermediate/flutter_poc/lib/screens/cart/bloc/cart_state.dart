part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<Grocery> cartItems;

  CartLoadedSuccessState({required this.cartItems});
}

class CartErrorState extends CartState {}

class RemoveFromCartState extends CartActionState {
  final List<Grocery> cartItems;

  RemoveFromCartState({required this.cartItems});
}
