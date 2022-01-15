import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartItems extends Equatable{
  final List<Product>products;
   final double total;
   final List<String> sizes;
   final List<int> colors;
   final String id;
   const CartItems({this.products=const<Product>[], this.total= 0,this.sizes=const[],this.colors=const[],this.id=''});

  @override
  List<Object?>get props=>products;
}