part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
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
