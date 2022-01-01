import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Orders extends Equatable {
  final List<Product> products;
  final double total;
  final int orderId;

  const Orders(
      {this.products = const <Product>[], this.total = 0, this.orderId = 0});

  @override
  List<Object?> get props => products;
}
