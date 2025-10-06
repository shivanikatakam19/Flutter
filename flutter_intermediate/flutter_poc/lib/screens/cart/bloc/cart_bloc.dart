import 'package:bloc/bloc.dart';
import 'package:flutter_poc/data/cart_items.dart';
import 'package:flutter_poc/models/grocery.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>((event, emit) async {
      emit(CartLoadingState());

      await Future.delayed(Duration(seconds: 2), () {
        emit(CartLoadedSuccessState(cartItems: cartItems));
      });
    });

    on<RemoveFromCartEvent>((event, emit) async {
      event.grocery.isAddedToCart = false;
      cartItems.remove(event.grocery);
      emit(RemoveFromCartState(cartItems: cartItems));
    });
  }
}
