import 'package:bruva/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Favorites extends Equatable {
  final List<Product> products;

  const Favorites({this.products = const <Product>[]});

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}
