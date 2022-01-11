part of 'product_bloc.dart';

@immutable
abstract class ProductState  {
   get  imagesList => [];
}

class ProductInitial extends ProductState {

}
class LoadingState extends ProductState{
}
class ProductsLoaded extends ProductState{
final  List<Product> products;
  ProductsLoaded({required this.products});}


class ErrorState extends ProductState{
 final String message;
  ErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}