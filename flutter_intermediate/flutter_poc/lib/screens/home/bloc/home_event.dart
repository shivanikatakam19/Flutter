part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonPressedEvent extends HomeEvent {
  final Grocery wishlistProduct;

  HomeProductWishlistButtonPressedEvent({required this.wishlistProduct});
}

class HomeProductCartButtonPressedEvent extends HomeEvent {
  final Grocery cartProduct;

  HomeProductCartButtonPressedEvent({required this.cartProduct});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
