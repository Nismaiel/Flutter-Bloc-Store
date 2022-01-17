import 'package:bruva/data/models/cart_model.dart';
import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Orders extends Equatable {
  final List<CartItems> cartItems;
  final String total;
  final int orderId;

  const Orders(
      {this.cartItems = const <CartItems>[], this.total = '', this.orderId = 0});

  @override
  List<Object?> get props => cartItems;
}
