import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartItems extends Equatable{
  final List<Product>products;
   final double total;
   const CartItems({this.products=const<Product>[], this.total= 0});

  @override
  List<Object?>get props=>products;
}