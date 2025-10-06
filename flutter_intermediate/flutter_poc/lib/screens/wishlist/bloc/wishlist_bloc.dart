import 'package:bloc/bloc.dart';
import 'package:flutter_poc/data/wishlist_items.dart';
import 'package:flutter_poc/models/grocery.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>((event, emit) async {
      emit(WishlistLoadingState());

      await Future.delayed(Duration(seconds: 2), () {
        emit(WishlistLoadedSuccessState(wishlistItems: wishlistItems));
      });
    });

    on<RemoveFromWishlistEvent>((event, emit) async {
      event.grocery.isAddedToWishlist = false;
      wishlistItems.remove(event.grocery);
      emit(RemoveFromWishlistState(wishlistItems: wishlistItems));
    });
  }
}
