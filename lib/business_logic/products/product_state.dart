part of 'product_bloc.dart';

@immutable
abstract class ProductState  {
   get  imagesList => [];
   get colorsList => [];

}

class ProductInitial extends ProductState {

}
class LoadingState extends ProductState{
}
class ProductsLoaded extends ProductState{
final  List<Product> products;
  ProductsLoaded({required this.products});}


class ImagesAdded extends ProductState {
  final List images;
 ImagesAdded({ this.images=const[]});

  @override
  List get imagesList => images;


}
class ColorsAdded extends ProductState{
  final List colors;
  ColorsAdded({this.colors=const[]});

  @override
  List get colorsList => colors;

}

class ErrorState extends ProductState{
 final String message;
  ErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}