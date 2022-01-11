part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProducts extends ProductEvent {}

class AddNewProduct extends ProductEvent {
  final List<File> images;
  final String name;
  final String price;
  final String beforeDiscount;
  final String description;
  final List colors;
  final List sizes;
  final String gender;
  final String category;
  final String subCategory;

  AddNewProduct(this.images, this.name, this.price, this.beforeDiscount,
      this.description, this.colors, this.sizes, this.gender,this.category,this.subCategory);
}
