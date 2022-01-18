


import 'package:bruva/data/models/favorites_model.dart';

abstract class FavoritesState  {
  const FavoritesState();

 List<Favorites> get favoritesList => [];
}

class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesInitial {}

class FavoritesLoaded extends FavoritesInitial {
  @override
  final List<Favorites> favorites;

  FavoritesLoaded({this.favorites = const []});

  @override
  List<Favorites> get favoritesList => favorites;
}

class FavoritesError extends FavoritesInitial {
  final String message;

  FavoritesError({required this.message});
}

