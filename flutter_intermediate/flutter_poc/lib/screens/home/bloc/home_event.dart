part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeProductWishlistButtonPressed extends HomeEvent {}

class HomeProductCartButtonPressed extends HomeEvent {}

class HomeWishlistButtonNavigate extends HomeEvent {}

class HomeCartButtonNavigate extends HomeEvent {}
