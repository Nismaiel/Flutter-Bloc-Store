part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class StartCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  final int color;
  final String size;

  const AddToCart({required this.product,required this.color,required this.size});

  @override
  List<Object> get props => [product];
}



class RemoveFromCart extends CartEvent {
  final Product product;
  const RemoveFromCart({required this.product});
  @override
  List<Object> get props => [product];
}