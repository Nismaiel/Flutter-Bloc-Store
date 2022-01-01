part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  get favorites => null;
}

class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesInitial {}

class FavoritesLoaded extends FavoritesInitial {
  @override
  final Favorites favorites;

  FavoritesLoaded({this.favorites = const Favorites()});

  @override
  List<Object> get props => [favorites];
}

class FavoritesError extends FavoritesInitial {
  final String message;

  FavoritesError({required this.message});
}
