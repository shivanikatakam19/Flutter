part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<Grocery> groceries;

  HomeLoadedSuccessState({required this.groceries});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigatetoCartPageActionState extends HomeActionState {}

class HomeProductWishlistButtonPressedState extends HomeActionState {}

class HomeProductCartButtonPressedState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductItemCartActionState extends HomeActionState {}
