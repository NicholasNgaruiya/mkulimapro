import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tunda/screens/disease_detection/cart/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    List<CartItem> _cartItems = [];
    on<AddToCartEvent>((event, emit) {
      _cartItems.add(event.item);
      emit(CartLoaded(List.of(_cartItems)));
    });

    on<RemoveFromCartEvent>((event, emit) {
      _cartItems.remove(event.item);
      emit(CartLoaded(List.of(_cartItems)));
    });
  }
}
