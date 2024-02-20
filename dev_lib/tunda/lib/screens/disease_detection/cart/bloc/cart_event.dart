part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItem item;

  AddToCartEvent(this.item);
}

class RemoveFromCartEvent extends CartEvent {
  final CartItem item;

  RemoveFromCartEvent(this.item);
}
