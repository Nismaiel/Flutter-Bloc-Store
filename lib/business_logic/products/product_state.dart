part of 'product_bloc.dart';

@immutable
 class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}
class LoadingState extends ProductState{}
class ProductsLoaded extends ProductState{
final  List<Product> products;
  ProductsLoaded({required this.products});

}
class ErrorState extends ProductState{
 final String message;
  ErrorState({required this.message});
}