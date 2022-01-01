part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  @override
  List<Object>get props=>[];
}
class GetProducts extends ProductEvent{}
