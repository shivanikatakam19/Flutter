part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedSuccessState extends WishlistState {
  final List<Grocery> wishlistItems;

  WishlistLoadedSuccessState({required this.wishlistItems});
}

class WishlistErrorState extends WishlistState {}

class RemoveFromWishlistState extends WishlistActionState {
  final List<Grocery> wishlistItems;

  RemoveFromWishlistState({required this.wishlistItems});
}
