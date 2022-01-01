part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class StartFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final Product product;

  const AddToFavorites({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveFromFavorites extends FavoritesEvent {
  final Product product;

  const RemoveFromFavorites({required this.product});

  @override
  List<Object> get props => [product];
}
