import 'package:bruva/data/models/cart_model.dart';

abstract class CartState  {
  const CartState();

  get cartItems => null;

}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartInitial {}

class CartLoaded extends CartInitial {
  @override
  final CartItems cartItems;

  CartLoaded({this.cartItems = const CartItems()});


  List<Object> get props => [cartItems];

}

class CartError extends CartInitial {
  final String message;

  CartError({required this.message});
}
